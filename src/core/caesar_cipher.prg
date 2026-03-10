/*
 _      _                                                  _         _
| |__  | |__     ___   __ _   ___  ___   __ _  _ __   ___ (_) _ __  | |__    ___  _ __
| '_ \ | '_ \   / __| / _` | / _ \/ __| / _` || '__| / __|| || '_ \ | '_ \  / _ \| '__|
| | | || |_) | | (__ | (_| ||  __/\__ \| (_| || |   | (__ | || |_) || | | ||  __/| |
|_| |_||_.__/   \___| \__,_| \___||___/ \__,_||_|    \___||_|| .__/ |_| |_| \___||_|

Released to Public Domain.                                                               |_|

*/

#include "hbver.ch"

PROCEDURE Main(...)

   LOCAL aArgs := hb_AParams()

   LOCAL cAction
   LOCAL cFileSource
   LOCAL cFileTarget
   LOCAL nShift := 3
   LOCAL lBase64 := .F.
   LOCAL lEx := .F.

   LOCAL cParam
   LOCAL cArg
   LOCAL idx

   LOCAL cData

   IF Empty(aArgs)
      ShowHelp()
      RETURN
   ENDIF

   FOR EACH cParam IN aArgs

      IF (idx := At("=",cParam)) > 0
         cArg := Lower(Left(cParam,idx-1))
         cParam := SubStr(cParam,idx+1)
      ELSE
         cArg := Lower(cParam)
         cParam := ""
      ENDIF

      SWITCH cArg

      CASE "-a"
      CASE "--action"
         cAction := Lower(Left(cParam,1))
         EXIT

      CASE "-s"
      CASE "--source"
         cFileSource := cParam
         EXIT

      CASE "-t"
      CASE "--target"
         cFileTarget := cParam
         EXIT

      CASE "-k"
      CASE "--key"
         nShift := Val(cParam)
         EXIT

      CASE "-b"
      CASE "--base64"
         lBase64 := (Lower(cParam) $ "1,t,true,y,yes")
         EXIT

      CASE "-x"
      CASE "--extended"
         lEx := (Lower(cParam) $ "1,t,true,y,yes")
         EXIT

      CASE "-h"
      CASE "--help"
         ShowHelp()
         RETURN

      END SWITCH

   NEXT

   IF Empty(cFileSource) .OR. !hb_FileExists(cFileSource)
      ? "Source file not found:", cFileSource
      RETURN
   ENDIF

   IF Empty(cFileTarget)
      ? "Target file not specified"
      RETURN
   ENDIF

   cData := hb_MemoRead(cFileSource)

   DO CASE

   CASE cAction == "e"

      IF lEx
         cData := hb_CaesarCipher():EncodeEx(cData,nShift,lBase64)
      ELSE
         cData := hb_CaesarCipher():Encode(cData,nShift,lBase64)
      ENDIF

   CASE cAction == "d"

      IF lEx
         cData := hb_CaesarCipher():DecodeEx(cData,nShift,lBase64)
      ELSE
         cData := hb_CaesarCipher():Decode(cData,nShift,lBase64)
      ENDIF

   OTHERWISE
      ? "Invalid action"
      RETURN

   ENDCASE

   hb_MemoWrit(cFileTarget,cData)

   ? "Done."
   ? "Source :", cFileSource
   ? "Target :", cFileTarget
   ? "Shift  :", nShift
   ? "Base64 :", lBase64
   ? "ModeEx :", lEx

RETURN


STATIC PROCEDURE ShowHelp()

   ?

   ? "HB Caesar Cipher Tool"
   ?
   ? "Usage:"
   ? "hb_caesar_cipher [options]"
   ?
   ? "-a=e|d         encrypt or decrypt"
   ? "-s=<file>      source file"
   ? "-t=<file>      target file"
   ? "-k=<shift>     shift key"
   ? "-b=true|false  base64 mode"
   ? "-x=true|false  extended mode"
   ?
   ? "Examples:"
   ?
   ? "Encrypt:"
   ? "hb_caesar_cipher -a=e -s=input.txt -t=out.enc -k=10"
   ?
   ? "Decrypt:"
   ? "hb_caesar_cipher -a=d -s=out.enc -t=input.txt -k=10"

RETURN

function hb_CaesarCipher()

    static s_ohb_CaesarCipherClass as object

    if (s_ohb_CaesarCipherClass==NIL)

        s_ohb_CaesarCipherClass:=HBClass():New("HB_CAESARCIPHER")

        s_ohb_CaesarCipherClass:AddMethod("Encode",@Encode())
        s_ohb_CaesarCipherClass:AddMethod("Decode",@Decode())
        s_ohb_CaesarCipherClass:AddMethod("BruteForceDecode",@BruteForceDecode())

        s_ohb_CaesarCipherClass:AddMethod("EncodeEx",@EncodeEx())
        s_ohb_CaesarCipherClass:AddMethod("DecodeEx",@DecodeEx())
        s_ohb_CaesarCipherClass:AddMethod("BruteForceDecodeEx",@BruteForceDecodeEx())

        s_ohb_CaesarCipherClass:AddMethod("NormalizeShift",@NormalizeShift())

        s_ohb_CaesarCipherClass:Create()

    endif

    return(s_ohb_CaesarCipherClass:Instance()) as object

static function Encode(cText as character,nShift as numeric,lBase64Encode as logical)

    local cOut as character :=""

    local lLower as logical

    local n as numeric
    local i as numeric
    local nChar as numeric
    local nShift26 as numeric

    //normaliza shifts (permite negativo)
    nShift26:=NormalizeShift(nShift,26)

    hb_Default(@lBase64Encode,.F.)
    if (lBase64Encode)
        cText:=hb_Base64Encode(cText)
    endif

    for i:=1 to hb_BLen(cText)

        nChar:=hb_BCode(hb_BSubStr(cText,i,1))

        // ======= LETRAS =======
        if (((nChar>=65).and.nChar<=90).or.((nChar>=97).and.(nChar<=122)))

            lLower:=hb_BitTest(nChar,5)
            n:=hb_BitReset(nChar,5)

            n:=n+nShift26
            if (n>90)
                n-=26
            endif

            if (lLower)
                n:=hb_BitSet(n,5)
            endif

            cOut+=Chr(n)

        // ======= OUTROS =======
        else
            cOut+=Chr(nChar)
        endif

    next i

return(cOut) as character

static function Decode(cText as character,nShift as numeric,lBase64Encode as logical)
    local cDecoded:=Encode(cText,nShift,.F.)
    hb_Default(@lBase64Encode,.F.)
    if (lBase64Encode)
        cDecoded:=hb_Base64Decode(cDecoded)
    endif
return(cDecoded) as character

static function BruteForceDecode(cText as character,nShift as numeric,nSignal as numeric,lBase64Encode as logical)

    local cTry as character
    local cKey as character

    local n as numeric
    local nKeySize as numeric

    local hBruteForceDecode:={=>}

    hb_Default(@nShift,115)
    hb_Default(@nSignal,(-1))
    hb_Default(@lBase64Encode,.F.)

    if (Empty(nSignal))
        nSignal:=(-1)
    elseif (nSignal<(-1))
        nSignal:=(-1)
    elseif (nSignal>1)
        nSignal:=1
    endif

    nKeySize:=Len(hb_NToC(nShift))

    for n:=0 to nShift
        cTry:=Decode(cText,(n*nSignal),lBase64Encode)
        cKey:=StrZero(n,nKeySize)
        hBruteForceDecode[cKey]:={=>}
        hBruteForceDecode[cKey]["shift"]:=n
        hBruteForceDecode[cKey]["value"]:=cTry
    next n

return(hBruteForceDecode) as hash

static function EncodeEx(cText as character,nShift as numeric,lBase64Encode as logical)

    local cOut as character :=""

    local lLower as logical

    local n as numeric
    local i as numeric
    local nChar as numeric
    local nShift10 as numeric
    local nShift26 as numeric

    //normaliza shifts (permite negativo)
    nShift26:=NormalizeShift(nShift,26)
    nShift10:=NormalizeShift(nShift*2+5,10)

    hb_Default(@lBase64Encode,.T.)
    if (lBase64Encode)
        cText:=hb_Base64Encode(cText)
    endif

    for i:=1 to hb_BLen(cText)

        nChar:=hb_BCode(hb_BSubStr(cText,i,1))

        // ======= LETRAS =======
        if (((nChar>=65).and.nChar<=90).or.((nChar>=97).and.(nChar<=122)))

            lLower:=hb_BitTest(nChar,5)
            n:=hb_BitReset(nChar,5)

            n:=n+nShift26
            if (n>90)
                n-=26
            endif

            if (lLower)
                n:=hb_BitSet(n,5)
            endif

            cOut+=Chr(n)

        // ======= NUMEROS =======
        elseif ((nChar>=48).and.(nChar<=57))

            n:=nChar+nShift10
            if (n>57)
                n-=10
            endif

            cOut+=Chr(n)

        // ======= OUTROS =======
        else
            cOut+=Chr(nChar)
        endif

    next i

return(cOut) as character

static function DecodeEx(cText as character,nShift as numeric,lBase64Encode as logical)
    local cDecoded:=EncodeEx(cText,nShift,.F.)
    hb_Default(@lBase64Encode,.T.)
    if (lBase64Encode)
        cDecoded:=hb_Base64Decode(cDecoded)
    endif
return(cDecoded) as character

static function BruteForceDecodeEx(cText as character,nShift as numeric,nSignal as numeric,lBase64Encode as logical)

    local cTry as character
    local cKey as character

    local n as numeric
    local nKeySize as numeric

    local hBruteForceDecode:={=>}

    hb_Default(@nShift,115)
    hb_Default(@nSignal,(-1))
    hb_Default(@lBase64Encode,.T.)

    if (Empty(nSignal))
        nSignal:=(-1)
    elseif (nSignal<(-1))
        nSignal:=(-1)
    elseif (nSignal>1)
        nSignal:=1
    endif

    nKeySize:=Len(hb_NToC(nShift))

    for n:=0 to nShift
        cTry:=DecodeEx(cText,(n*nSignal),lBase64Encode)
        cKey:=StrZero(n,nKeySize)
        hBruteForceDecode[cKey]:={=>}
        hBruteForceDecode[cKey]["shift"]:=n
        hBruteForceDecode[cKey]["value"]:=cTry
    next n

return(hBruteForceDecode) as hash

static function NormalizeShift(n as numeric,b as numeric)

   local r as numeric

   r:=(n-(Int(n/b)*b))   // resto truncado

   if (r<0)
      r+=b
   endif

return(r) as numeric
