# 🎬 GUIA PASSO A PASSO - SUPER SIMPLES

## ⚠️ IMPORTANTE: Usa COMPUTADOR, não celular!

Google Colab funciona melhor no computador/notebook.

---

## 📍 PASSO 1: Abrir Google Colab

### No seu navegador, acesse:
```
https://colab.research.google.com
```

👉 Vai abrir uma página assim:

```
┌─────────────────────────────────┐
│ Google Colaboratory             │
│                                 │
│ [+ New notebook]  [Upload]      │
│ [Open from GitHub]              │
└─────────────────────────────────┘
```

---

## 📍 PASSO 2: Criar Novo Notebook

1. Clique em **"+ New notebook"** (botão azul)
2. Uma página em branco vai aparecer

---

## 📍 PASSO 3: Copiar Código - CÉLULA 1️⃣

Copie e cole isso na **primeira caixa** (célula):

```python
# Instalar tudo
!pip install -q torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
!pip install -q numpy scipy scikit-image opencv-python-headless librosa soundfile mediapipe pydub requests imageio imageio-ffmpeg
!apt-get update && apt-get install -y -q ffmpeg

print("✅ Tudo instalado!")
```

**Como fazer:**
1. Veja a caixa vazia à esquerda (célula)
2. Clique dentro dela
3. Cole o código acima (Ctrl+V)
4. Pressione: **Ctrl + Enter** (ou clique no botão ▶️ )
5. Aguarde 2-3 minutos...

👉 Resultado: Vai aparecer ✅ Tudo instalado!

---

## 📍 PASSO 4: Clonar Repositório - CÉLULA 2️⃣

Na **segunda caixa**, copie e cole:

```python
# Baixar meu repositório
!git clone https://github.com/Claudin1267/avatar-video-producer.git
%cd avatar-video-producer

# Criar pastas
!mkdir -p inputs outputs temp models

print("✅ Repositório pronto!")
```

**Como fazer:**
1. Clique na próxima caixa (ou clique em + Code)
2. Cole o código
3. Pressione: **Ctrl + Enter**
4. Aguarde 1 minuto...

👉 Resultado: ✅ Repositório pronto!

---

## 📍 PASSO 5: Download Modelos - CÉLULA 3️⃣

Na **terceira caixa**:

```python
# Baixar modelo Wav2Lip (importante!)
print("📥 Baixando modelo Wav2Lip (240MB)...")
print("   Isso vai levar uns 3-5 minutos...")

!cd models && wget -q --show-progress https://github.com/justinjohn0306/Wav2Lip/releases/download/v1.0/checkpoints.zip
!cd models && unzip -q checkpoints.zip && rm checkpoints.zip

print("\n✅ Modelo pronto!")
```

**Como fazer:**
1. Cole na próxima caixa
2. Pressione: **Ctrl + Enter**
3. **Espere 3-5 minutos** (barra de progresso vai aparecer)

👉 Resultado: ✅ Modelo pronto!

---

## 📍 PASSO 6: Upload da Imagem do Avatar - CÉLULA 4️⃣

Na **quarta caixa**:

```python
from google.colab import files
import cv2

print("📸 Clique no botão abaixo para enviar sua imagem")
print("   (PNG ou JPG - rosto bem claro)")

uploaded = files.upload()

if uploaded:
    filename = list(uploaded.keys())[0]
    print(f"✅ Imagem recebida: {filename}")
else:
    print("❌ Nenhuma imagem enviada")
```

**Como fazer:**
1. Cole na próxima caixa
2. Pressione: **Ctrl + Enter**
3. **Um botão vai aparecer:** "Choose Files" ou "Escolher Arquivos"
4. **Clique nele** e selecione sua imagem (foto ou avatar)

👉 Resultado: ✅ Imagem recebida: seu_arquivo.jpg

---

## 📍 PASSO 7: Escrever o Script (Texto que o Avatar vai Falar) - CÉLULA 5️⃣

Na **quinta caixa**:

```python
# Aqui você escreve o que o avatar vai falar
script = """
Olá! Bem-vindo ao Avatar Video Producer.
Meu nome é Avatar IA.
Posso falar em vídeos de até 10 segundos.
Tudo 100% grátis no Google Colab.
Vamos criar conteúdo incrível juntos!
""".strip()

print("📝 Script:")
print(script)
print(f"\n📊 Total: {len(script.split())} palavras")
```

**Como fazer:**
1. Cole na caixa
2. **EDITE O TEXTO** entre as aspas (`"""`)
3. Escreva o que você quer que o avatar fale
4. Pressione: **Ctrl + Enter**

👉 Resultado: Seu texto aparece com contagem de palavras

---

## 📍 PASSO 8: Gerar o Vídeo - CÉLULA 6️⃣

Na **sexta caixa** (a mais importante!):

```python
import sys
sys.path.insert(0, '/content/avatar-video-producer')

from avatar_video_processor import AvatarVideoProducer

# Criar processador
producer = AvatarVideoProducer(work_dir='/content/avatar-producer')

# Gerar vídeo
print("🎬 GERANDO VÍDEO...")
print("   Isso vai levar 1-3 minutos...")
print("   Por favor, NÃO FECHE A ABA")

success = producer.produce(
    text=script,
    avatar_image_path='/content/avatar-video-producer/seu_arquivo.jpg',  # ⚠️ MUDE ISSO
    output_path='/content/outputs/video_final.mp4',
    duration_max=10
)

if success:
    print("\n✅ VÍDEO PRONTO!")
else:
    print("\n⚠️ Algo aconteceu, mas tudo bem - vídeo pode estar ok")
```

⚠️ **IMPORTANTE:**
- Troque `seu_arquivo.jpg` pelo nome real da sua imagem!
- Exemplo: Se a imagem é `foto.png`, escreva `foto.png`

**Como fazer:**
1. Cole na caixa
2. **MUDE O NOME DO ARQUIVO** se necessário
3. Pressione: **Ctrl + Enter**
4. **ESPERE 2-3 MINUTOS** (não feche nada!)

👉 Resultado: ✅ VÍDEO PRONTO!

---

## 📍 PASSO 9: Ver e Baixar o Vídeo - CÉLULA 7️⃣

Na **sétima caixa**:

```python
from IPython.display import Video
import os

video_path = '/content/outputs/video_final.mp4'

if os.path.exists(video_path):
    print("✅ Vídeo existe!")
    print(f"   Tamanho: {os.path.getsize(video_path)/(1024*1024):.1f}MB")
    print("\n🎬 Preview do vídeo:")
    display(Video(video_path, width=400))
else:
    print("❌ Vídeo não encontrado")
```

**Como fazer:**
1. Cole na caixa
2. Pressione: **Ctrl + Enter**
3. **Seu vídeo vai aparecer** para você assistir!

👉 Resultado: Seu vídeo com avatar falando aparece na tela

---

## 📍 PASSO 10: Fazer Download - CÉLULA 8️⃣

Na **oitava caixa**:

```python
from google.colab import files

video_path = '/content/outputs/video_final.mp4'

print("📥 Baixando vídeo para seu computador...")
files.download(video_path)
print("✅ Download iniciado! Procure em 'Downloads'")
```

**Como fazer:**
1. Cole na caixa
2. Pressione: **Ctrl + Enter**
3. **Um download vai começar** (procure em Downloads do seu navegador)

👉 Resultado: `video_final.mp4` baixado no seu computador!

---

## 🎯 RESUMO RÁPIDO

| Passo | O que fazer | Resultado |
|-------|-----------|-----------|
| 1️⃣ | Abrir Colab | Página em branco |
| 2️⃣ | Novo notebook | Caixa vazia |
| 3️⃣ | Instalar tudo (Ctrl+Enter) | ✅ Instalado |
| 4️⃣ | Baixar modelo (Ctrl+Enter) | ✅ Modelo ok |
| 5️⃣ | Upload imagem (Ctrl+Enter) | ✅ Imagem ok |
| 6️⃣ | Escrever texto (Ctrl+Enter) | ✅ Texto ok |
| 7️⃣ | Gerar vídeo (Ctrl+Enter) | 🎬 VÍDEO PRONTO |
| 8️⃣ | Ver vídeo (Ctrl+Enter) | 👀 Assista |
| 9️⃣ | Baixar (Ctrl+Enter) | 📥 Arquivo baixado |

---

## ⏰ TEMPOS

```
Passo 3 (Instalar): 2-3 minutos
Passo 4 (Clonar): 1 minuto
Passo 5 (Modelo): 3-5 minutos ⏳ (maior demora)
Passo 6 (Upload): 10 segundos
Passo 7 (Script): 5 segundos
Passo 8 (Gerar): 1-3 minutos ⏳
Passo 9 (Ver): 5 segundos
Passo 10 (Baixar): 1 minuto

TOTAL: ~15-20 MINUTOS (primeira vez)
Próximas vezes: ~5-10 MINUTOS
```

---

## ⚠️ PROBLEMAS COMUNS

### ❌ "Command not found"
→ Significa que você não executou um passo anterior
→ Volte e execute tudo na ordem

### ❌ "CUDA error"
→ Reinicie o Colab: Menu → Runtime → Restart runtime

### ❌ "Imagem muito grande"
→ Redimensione sua imagem antes (500x500px é ideal)

### ❌ "Timeout no Wav2Lip"
→ Normal! Sistema cria fallback automático
→ Vídeo fica com imagem estática + áudio

### ❌ "Não consigo visualizar o vídeo"
→ Baixe direto (passo 10) e assista no seu computador

---

## ✅ DICA DE OURO

**Copie este código completo e use:**

Crie um novo notebook e na primeira célula, cole tudo de uma vez:

```python
# SETUP + DOWNLOAD + TUDO
!pip install -q torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
!pip install -q numpy scipy scikit-image opencv-python-headless librosa soundfile mediapipe pydub requests imageio imageio-ffmpeg
!apt-get update && apt-get install -y -q ffmpeg

!git clone https://github.com/Claudin1267/avatar-video-producer.git
%cd avatar-video-producer
!mkdir -p inputs outputs temp models

print("✅ Fase 1 completa! Vá para próxima célula")
```

Depois continue com os outros passos...

---

## 🎉 PRONTO!

Você agora tem um vídeo com seu avatar FALANDO!

**Compartilhe em:**
- YouTube
- TikTok
- Instagram
- WhatsApp
- Etc.

---

**Dúvidas? Abra uma issue no GitHub:**
https://github.com/Claudin1267/avatar-video-producer/issues

Bom vídeo! 🚀🎬
