#ifndef SW_SHA256_H
#define SW_SHA256_H

#include <stdint.h>
#include <stdbool.h>
#include <SW_SHA256_regs.h>

void SW_SHA256_writeBlock(uint32_t sha256_base, int *block, bool isFirst);

int SW_SHA256_ready(uint32_t sha256_base);

void SW_SHA256_waitReady(uint32_t sha256_base);

int SW_SHA256_resultValid(uint32_t sha256_base);

void SW_SHA256_waitResultValid(uint32_t sha256_base);

int SW_SHA256_readControl(uint32_t sha256_base);

void SW_SHA256_writeControl(uint32_t sha256_base, int control);

void SW_SHA256_writeMode(uint32_t sha256_base, bool is265);

void SW_SHA256_sendInit(uint32_t sha256_base);

void SW_SHA256_sendNext(uint32_t sha256_base);

void SW_SHA256_readDigest(uint32_t sha256_base, int *digest);

void SW_SHA256_sendBlockFirst(uint32_t sha256_base, int *blocks0,int *blocks1, bool is265);

void SW_SHA256_sendBlock(uint32_t sha256_base, int *blocks0,int *blocks1);

void SW_SHA256_waitGetResult(uint32_t sha256_base, int *result);

void SW_SHA256_setInterruptMask(uint32_t sha256_base, int mask);

#endif