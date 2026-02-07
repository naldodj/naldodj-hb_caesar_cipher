/*

    #### Harbour : hb_CaesarCipher (Baseado no original escrito em py e fornecido no curso Harkers do Bem )
    Para executar os códigos desenvolvidos em Harbour, utilize o [Harbour WASM](https://fivetechsoft.github.io/harbour_wasm/).

    Released to Public Domain.
    --------------------------------------------------------------------------------------

*/

function Main()

    local cKey as character
    local cText as character
    local cHSep as character:=Replicate("=",120)
    local cCaesarCipherEncoded as character
    local cCaesarCipherDecoded as character

    local nStep as numeric:=0
    local nShift as numeric
    local hBruteForceDecode as hash

    nShift:=10

    ? cHSep,"<br/>"
    ? "<pre>",PADC("NORMAL :: Shift("+hb_NToC(nShift)+")",120," "),"</pre>"
    ? cHSep,"<br/>"

    cText:="Hackers do bem - Fundamental - 02/2026"
    ? "Text: ",cText,"<br/>"

    ? cHSep,"<br/>"

    cCaesarCipherEncoded:=hb_CaesarCipher():Encode(cText,nShift)
    ? "Encoded: ",cCaesarCipherEncoded,"<br/>"

    cCaesarCipherDecoded:=hb_CaesarCipher():Decode(cCaesarCipherEncoded,-nShift)
    ? "Decoded: ",cCaesarCipherDecoded,"<br/>"

    cBruteForce:=""
    hBruteForceDecode:=hb_CaesarCipher():BruteForceDecode(cCaesarCipherEncoded)
    for each cKey in hb_HKeys(hBruteForceDecode)
        cCaesarCipherEncoded:=hBruteForceDecode[cKey]["value"]
        if (cCaesarCipherEncoded==cText)
            nStep:=hBruteForceDecode[cKey]["shift"]
            cBruteForce:=cCaesarCipherEncoded
            exit
        endif
    next //each

    ? "BruteForce: ",cBruteForce," :: Step: ",hb_NToc(nStep),"<br/>"

    nShift:=115
    ? cHSep,"<br/>"
    ? "<pre>",PADC("NORMAL BASE64 :: Shift("+hb_NToC(nShift)+")",120," "),"</pre>"
    ? cHSep,"<br/>"

    ? "nShift: ",nShift,"<br/>"

    ? cHSep,"<br/>"

    cCaesarCipherEncoded:=hb_CaesarCipher():Encode(hb_Base64Encode(cText),nShift)
    ? "Encoded: ",cCaesarCipherEncoded,"<br/>"

    cCaesarCipherDecoded:=hb_Base64Decode(hb_CaesarCipher():Decode(cCaesarCipherEncoded,-nShift))
    ? "Decoded: ",cCaesarCipherDecoded,"<br/>"

    cBruteForce:=""
    hBruteForceDecode:=hb_CaesarCipher():BruteForceDecode(cCaesarCipherEncoded)
    for each cKey in hb_HKeys(hBruteForceDecode)
        cCaesarCipherEncoded:=hb_Base64Decode(hBruteForceDecode[cKey]["value"])
        if (cCaesarCipherEncoded==cText)
            nStep:=hBruteForceDecode[cKey]["shift"]
            cBruteForce:=cCaesarCipherEncoded
            exit
        endif
    next //each

    ? "BruteForce: ",cBruteForce," :: Step: ",hb_NToc(nStep),"<br/>"

    ? cHSep,"<br/>"
    ? "<pre>",PADC("EXTENDED :: Shift("+hb_NToC(nShift)+")",120," "),"</pre>"
    ? cHSep,"<br/>"

    cText:="São Paulo, 1 de Outubro de 1992. 8 horas da manhã..."
    ? "Text: ",cText,"<br/>"

    ? cHSep,"<br/>"

    cCaesarCipherEncoded:=hb_CaesarCipher():EncodeEx(cText,nShift)
    ? "Encoded: ",cCaesarCipherEncoded,"<br/>"

    cCaesarCipherDecoded:=hb_CaesarCipher():DecodeEx(cCaesarCipherEncoded,-nShift)
    ? "Decoded: ",cCaesarCipherDecoded,"<br/>"

    cBruteForce:=""
    hBruteForceDecode:=hb_CaesarCipher():BruteForceDecodeEx(cCaesarCipherEncoded)
    for each cKey in hb_HKeys(hBruteForceDecode)
        cCaesarCipherEncoded:=hBruteForceDecode[cKey]["value"]
        if (cCaesarCipherEncoded==cText)
            nStep:=hBruteForceDecode[cKey]["shift"]
            cBruteForce:=cCaesarCipherEncoded
            exit
        endif
    next //each

    ? "BruteForce: ",cBruteForce," :: Step: ",hb_NToc(nStep),"<br/>"


    nShift:=115

    ? cHSep,"<br/>"
    ? "<pre>",PADC("EXTENDED BASE64 :: Shift("+hb_NToC(nShift)+")",120," "),"</pre>"
    ? cHSep,"<br/>"

    cCaesarCipherEncoded:=hb_CaesarCipher():EncodeEx(hb_Base64Encode(cText),nShift)
    ? "Encoded: ",cCaesarCipherEncoded,"<br/>"

    cCaesarCipherDecoded:=hb_Base64Decode(hb_CaesarCipher():DecodeEx(cCaesarCipherEncoded,-nShift))
    ? "Decoded: ",cCaesarCipherDecoded,"<br/>"

    cBruteForce:=""
    hBruteForceDecode:=hb_CaesarCipher():BruteForceDecodeEx(cCaesarCipherEncoded)
    for each cKey in hb_HKeys(hBruteForceDecode)
        cCaesarCipherEncoded:=hb_Base64Decode(hBruteForceDecode[cKey]["value"])
        if (cCaesarCipherEncoded==cText)
            nStep:=hBruteForceDecode[cKey]["shift"]
            cBruteForce:=cCaesarCipherEncoded
            exit
        endif
    next //each

    ? "BruteForce: ",cBruteForce," :: Step: ",hb_NToc(nStep),"<br/>"

    nShift:=11
    ? cHSep,"<br/>"
    ? "<pre>",PADC("EXTENDED :: Shift("+hb_NToC(nShift)+")",120," "),"</pre>"
    ? cHSep,"<br/>"

    cCaesarCipherEncoded:=hb_CaesarCipher():EncodeEx(cText,11)
    ? "Encoded: ",cCaesarCipherEncoded ,"<br/>"
    cCaesarCipherDecoded:=hb_CaesarCipher():DecodeEx(cCaesarCipherEncoded,-11)
    ? "Decoded: ",cCaesarCipherDecoded,"<br/>"

    nStep:=0
    cBruteForce:=""
    hBruteForceDecode:=hb_CaesarCipher():BruteForceDecodeEx(cCaesarCipherEncoded)
    for each cKey in hb_HKeys(hBruteForceDecode)
        if (hBruteForceDecode[cKey]["value"]==cText)
            nStep:=hBruteForceDecode[cKey]["shift"]
            cBruteForce:=hBruteForceDecode[cKey]["value"]
            exit
        endif
    next //each

    ? "BruteForce: ",cBruteForce," :: Step: ",hb_NToc(nStep),"<br/>"

    ? cHSep,"<br/>"

    ? 'hb_CaesarCipher():EncodeEx(cText,'+hb_NToC(nShift)+')==hb_CaesarCipher():EncodeEx(cText,11): ',hb_CaesarCipher():EncodeEx(cText,nShift)==hb_CaesarCipher():EncodeEx(cText,11),"<br/>"

    nShift:=900
    ? cHSep,"<br/>"
    ? "<pre>",PADC("EXTENDED :: Shift("+hb_NToC(nShift)+")",120," "),"</pre>"
    ? cHSep,"<br/>"

    cCaesarCipherEncoded:=hb_CaesarCipher():EncodeEx(cText,nShift)
    ? "Encoded: ",cCaesarCipherEncoded,"<br/>"

    cCaesarCipherDecoded:=hb_CaesarCipher():DecodeEx(cCaesarCipherEncoded,-nShift)
    ? "Decoded: ",cCaesarCipherDecoded,"<br/>"

    cBruteForce:=""
    hBruteForceDecode:=hb_CaesarCipher():BruteForceDecodeEx(cCaesarCipherEncoded,1000)
    for each cKey in hb_HKeys(hBruteForceDecode)
        if (hBruteForceDecode[cKey]["value"]==cText)
            nStep:=hBruteForceDecode[cKey]["shift"]
            cBruteForce:=hBruteForceDecode[cKey]["value"]
            exit
        endif
    next //each

    ? "BruteForce: ",cBruteForce," :: Step: ",hb_NToc(nStep),"<br/>"

    ? cHSep,"<br/>"

return

/*
 _      _                                                  _         _
| |__  | |__     ___   __ _   ___  ___   __ _  _ __   ___ (_) _ __  | |__    ___  _ __
| '_ \ | '_ \   / __| / _` | / _ \/ __| / _` || '__| / __|| || '_ \ | '_ \  / _ \| '__|
| | | || |_) | | (__ | (_| ||  __/\__ \| (_| || |   | (__ | || |_) || | | ||  __/| |
|_| |_||_.__/   \___| \__,_| \___||___/ \__,_||_|    \___||_|| .__/ |_| |_| \___||_|
                                                               |_|
*/
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

static function Encode(cText as character,nShift as numeric)

    local cOut as character :=""

    local lLower as logical

    local n as numeric
    local i as numeric
    local nChar as numeric
    local nShift26 as numeric

    //normaliza shifts (permite negativo)
    nShift26:=NormalizeShift(nShift,26)

    for i:=1 to Len(cText)

        nChar:=hb_bCode(hb_BSubStr(cText,i,1))

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

return(cOut)

static function Decode(cText as character,nShift as numeric)
return(Encode(cText,nShift))

static function BruteForceDecode(cText as character,nShift as numeric,nSignal as numeric)

    local cTry as character
    local cKey as character

    local n as numeric
    local nKeySize as numeric

    local hBruteForceDecode:={=>}

    hb_Default(@nShift,115)
    hb_Default(@nSignal,(-1))

    if (Empty(nSignal))
        nSignal:=(-1)
    elseif (nSignal<(-1))
        nSignal:=(-1)
    elseif (nSignal>1)
        nSignal:=1
    endif

    nKeySize:=Len(hb_NToC(nShift))

    for n:=0 to nShift
        cTry:=Decode(cText,(n*nSignal))
        cKey:=StrZero(n,nKeySize)
        hBruteForceDecode[cKey]:={=>}
        hBruteForceDecode[cKey]["shift"]:=n
        hBruteForceDecode[cKey]["value"]:=cTry
    next n

return(hBruteForceDecode)

static function EncodeEx(cText as character,nShift as numeric)

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

    for i:=1 to Len(cText)

        nChar:=hb_bCode(hb_BSubStr(cText,i,1))

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

return(cOut)

static function DecodeEx(cText as character,nShift as numeric)
return(EncodeEx(cText,nShift))

static function BruteForceDecodeEx(cText as character,nShift as numeric,nSignal as numeric)

    local cTry as character
    local cKey as character

    local n as numeric
    local nKeySize as numeric

    local hBruteForceDecode:={=>}

    hb_Default(@nShift,115)
    hb_Default(@nSignal,(-1))

    if (Empty(nSignal))
        nSignal:=(-1)
    elseif (nSignal<(-1))
        nSignal:=(-1)
    elseif (nSignal>1)
        nSignal:=1
    endif

    nKeySize:=Len(hb_NToC(nShift))

    for n:=0 to nShift
        cTry:=DecodeEx(cText,(n*nSignal))
        cKey:=StrZero(n,nKeySize)
        hBruteForceDecode[cKey]:={=>}
        hBruteForceDecode[cKey]["shift"]:=n
        hBruteForceDecode[cKey]["value"]:=cTry
    next n

return(hBruteForceDecode)

static function NormalizeShift(n,b)

   local r as numeric

   r:=n-(Int(n/b)*b)   // resto truncado

   if (r<0)
      r+=b
   endif

return(r)
