#
# Audio samples → text (absolute paths via HOME)
#

MODEL := large-v3-turbo

WHISPER_CPP_DIR := $(HOME)/open_src/whisper.cpp
WHISPER_BIN := $(WHISPER_CPP_DIR)/build/bin/whisper-cli
MODEL_PATH  := $(WHISPER_CPP_DIR)//models/ggml-$(MODEL).bin

WAVS := $(wildcard *.wav)
TXTS := $(patsubst %.wav,%.txt,$(WAVS))

.PHONY: all clean check

all: check $(TXTS)

check:
	@test -x "$(WHISPER_BIN)" || (echo "whisper-cli not found: $(WHISPER_BIN)"; exit 1)
	@test -f "$(MODEL_PATH)"  || (echo "model file not found: $(MODEL_PATH)"; exit 1)

%.txt: %.wav
	$(WHISPER_BIN) -m "$(MODEL_PATH)" -f "$<" | tee "$@"

clean:
	rm -f *.txt

