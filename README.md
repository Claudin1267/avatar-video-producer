# 🎬 Avatar Video Producer - Google Colab Edition

**Produz vídeos com avatar falando (até 10 segundos) - 100% GRÁTIS no Google Colab**

![GitHub](https://img.shields.io/badge/License-MIT-green)
![Python](https://img.shields.io/badge/Python-3.8%2B-blue)
![GPU](https://img.shields.io/badge/GPU-CUDA-green)

---

## 🚀 Quick Start (30 segundos)

```
1. Abra: https://colab.research.google.com
2. Novo notebook
3. Cole:
   !git clone https://github.com/Claudin1267/avatar-video-producer.git
   !cp avatar-video-producer/*.ipynb .
4. Abra: colab_avatar_video.ipynb
5. Execute as células (top → bottom)
```

---

## 📋 O que você precisa

| Item | Formato | Tamanho | Nota |
|------|---------|---------|------|
| **Imagem Avatar** | PNG / JPG | ~1-5MB | Rosto claro, bem iluminado |
| **Script** | Texto | ~50-200 palavras | Máx 10 segundos (≈60 palavras/min) |
| **GPU Colab** | T4 ou V100 | Grátis | Recomendado: T4+ |
| **Tempo** | - | ~2-5min | Inclui download de modelos |

---

## 🎯 Como Usar

### Passo 1: Preparar Imagem do Avatar

Ideal:
- ✅ Rosto bem centralizado
- ✅ Boa iluminação (sem sombras)
- ✅ Fundo claro ou simples
- ✅ Câmera frontal (0-30°)

Ruim:
- ❌ De perfil
- ❌ Muito escuro
- ❌ Múltiplas pessoas
- ❌ Muito zoom/longe

### Passo 2: Abrir Notebook Colab

Link direto:
```
https://colab.research.google.com/github/Claudin1267/avatar-video-producer/blob/main/colab_avatar_video.ipynb
```

### Passo 3: Executar Células (7 Fases)

```
1️⃣  FASE 0 - Setup (instala dependências)
2️⃣  FASE 1 - Download Modelos (Wav2Lip)
3️⃣  FASE 2 - Importar Processor
4️⃣  FASE 3 - Upload Avatar
5️⃣  FASE 4 - Escrever Script
6️⃣  FASE 5 - Gerar Vídeo ✨
7️⃣  FASE 6 - Download MP4
```

---

## 🛠️ Arquitetura Técnica

```
TEXTO
  ↓
TTS (Fish Speech) → ÁUDIO
  ↓
Face Detection (MediaPipe)
  ↓
IMAGEM AVATAR + ÁUDIO
  ↓
Wav2Lip (Lip-sync)
  ↓
VIDEO COM LÁBIOS SINCRONIZADOS
  ↓
FFmpeg (Encode)
  ↓
MP4 FINAL (1080p, 10s, 50-100MB)
```

---

## 🔌 Componentes

| Componente | Engine | Qualidade | Grátis |
|-----------|--------|-----------|--------|
| **TTS** | Fish Speech | ⭐⭐⭐⭐⭐ | ✅ |
| **Lip-Sync** | Wav2Lip | ⭐⭐⭐⭐ | ✅ |
| **Face Detection** | MediaPipe | ⭐⭐⭐⭐⭐ | ✅ |
| **Encoding** | FFmpeg | ⭐⭐⭐⭐⭐ | ✅ |

---

## 💻 Requisitos

| Recurso | Mínimo | Recomendado |
|---------|--------|-------------|
| GPU | T4 | V100 |
| RAM | 12GB | 16GB+ |
| Espaço | 2GB | 5GB |
| Tempo | 3-5min | 1-2min |

---

## 📊 Saída

```
Formato: MP4 (H.264)
Resolução: 1080p
FPS: 25
Duração: até 10s
Tamanho: 50-100MB
Áudio: AAC 128kbps
```

---

## 🐛 Troubleshooting

| Erro | Solução |
|------|---------|
| Wav2Lip timeout | Usar fallback automático (imagem + áudio) |
| CUDA out of memory | Reiniciar runtime / GPU V100 |
| TTS falha | Verificar internet / Usar Piper |
| ModuleNotFoundError | Executar FASE 0 / Restart runtime |

---

## 🚀 Próximas Versões

- Docker local
- Batch processing
- API REST
- Interface web
- Clone de voz
- Corpo completo

---

## 📚 Referências

- [Wav2Lip Paper](https://arxiv.org/abs/2008.10010)
- [MediaPipe](https://github.com/google/mediapipe)
- [Fish Speech](https://github.com/fishaudio/fish-speech)

---

## 📄 Licença

MIT - Use livremente

---

**Criado com ❤️ para democratizar criação de conteúdo**

⭐ Se gostou, deixa uma star!
