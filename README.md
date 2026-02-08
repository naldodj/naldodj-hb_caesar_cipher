# 🧠 hb_CaesarCipher — Caesar Cipher em Harbour (com UTF-8, Base64 e Brute Force)

Implementação completa da **Cifra de César em Harbour**, baseada no algoritmo original em Python apresentado no curso **Hackers do Bem**, porém **estendida**, **corrigida** e **turbinada** para o mundo real:
UTF-8, números, brute-force inteligente e suporte a shifts gigantes.

Tudo isso rodando no navegador via **Harbour WASM**:

👉 [https://fivetechsoft.github.io/harbour_wasm/](https://fivetechsoft.github.io/harbour_wasm/)

Projeto liberado em **Public Domain**.

---

## ✨ O problema real

A Cifra de César clássica só funciona direito quando:

* o alfabeto é limitado (A–Z)
* o shift está entre 0 e 25
* o texto é ASCII puro

Mas o mundo real tem:

* **acentos**
* **UTF-8**
* **números**
* **shifts tipo 115, 900, 2048**
* **brute force**

Esse projeto resolve tudo isso.

---

## 🧩 Arquitetura

A classe `hb_CaesarCipher()` expõe dois modos:

| Modo              | O que cifra                |
| ----------------- | -------------------------- |
| **Normal**        | Apenas letras (A–Z, a–z)   |
| **Extended (Ex)** | Letras **e números** (0–9) |

E dois pipelines:

| Pipeline            | Para quê                               |
| ------------------- | -------------------------------------- |
| Texto direto        | ASCII simples                          |
| **Base64 + Caesar** | UTF-8, acentos, emojis, qualquer coisa |

---

## 🔑 Normalização de Shift

Shifts gigantes não quebram nada.

```harbour
NormalizeShift( nShift, base )
```

Exemplos:

| Shift | Base | Resultado |
| ----- | ---- | --------- |
| 115   | 26   | 11        |
| 900   | 26   | 16        |
| -3    | 26   | 23        |

Nada de loop lento, só matemática limpa.

---

## 🧪 Demonstração (Main)

O `Main()` testa quatro cenários:

### 1️⃣ Caesar Normal

```text
Hackers do bem - Fundamental - 02/2026
Shift: 10
```

Só letras mudam.
Números e símbolos ficam.

---

### 2️⃣ Caesar + Base64

```text
Shift: 115
Texto → Base64 → Caesar → Base64 → Texto
```

Isso permite usar **shifts gigantes** sem colisão falsa.

---

### 3️⃣ Extended (letras + números)

```text
São Paulo, 1 de Outubro de 1992. 8 horas da manhã...
```

Aqui:

* letras usam base 26
* números usam base 10 com um shift derivado

Resultado: datas, horários e números também são cifrados.

---

### 4️⃣ Extended + Base64 (modo canônico)

É o modo **correto** para texto real:

```text
UTF-8 → Base64 → CaesarEx → Base64 → UTF-8
```

Com isso:

* acentos não quebram
* brute force continua funcionando
* shifts enormes continuam únicos

---

## 🧨 Brute Force de verdade

Funções:

```harbour
BruteForceDecode()
BruteForceDecodeEx()
```

Elas geram um **hash**:

```harbour
{
  "000": { shift: 0,  value: "..." },
  "001": { shift: 1,  value: "..." },
  ...
  "115": { shift: 115, value: "São Paulo..." }
}
```

Você pode:

* procurar por palavras
* detectar datas
* validar idioma
* achar o shift real

Sem falsos positivos quando Base64 é usado.

---

## 🧬 Por que Base64?

UTF-8 usa bytes variáveis.
César só entende bytes previsíveis.

Base64 transforma isso:

```
São
```

em:

```
U8Oj
```

Ou seja:

```
[A–Z][a–z][0–9]+/
```

Perfeito para cifrar.

---

## 🧠 Em resumo

Este projeto entrega:

✔ Cifra de César clássica
✔ Suporte a números
✔ Suporte a UTF-8
✔ Base64 seguro
✔ Shifts gigantes
✔ Brute force funcional
✔ Harbour puro
✔ Executa no browser

Old school por fora.
Cripto-punk por dentro.

---

## 🚀 Execução

Copie o código e rode em:

👉 [https://fivetechsoft.github.io/harbour_wasm/](https://fivetechsoft.github.io/harbour_wasm/)

Sem instalação.
Sem desculpa.

---

## 🏴‍☠️ Licença

Public Domain.

---

<img width="1359" height="726" alt="image" src="https://github.com/user-attachments/assets/3d4ff29d-6390-435b-800f-4b6d0e0b0477" />

<p align="center">
  <a href="https://www.youtube.com/watch?v=2H8mQpeujh4">
    <img src="https://img.youtube.com/vi/2H8mQpeujh4/hqdefault.jpg">
  </a>
</p>
