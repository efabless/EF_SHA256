#ifndef EF_SHA256_C
#define EF_SHA256_C

#include <EF_SHA256.h>

void EF_SHA256_writeBlock(uint32_t sha256_base, int *block, bool isFirst){

    EF_SHA256_TYPE* sha256 = (EF_SHA256_TYPE*)sha256_base;
    if (isFirst){
        sha256->BLOCK0 = block[7];
        sha256->BLOCK1 = block[6];
        sha256->BLOCK2 = block[5];
        sha256->BLOCK3 = block[4];
        sha256->BLOCK4 = block[3];
        sha256->BLOCK5 = block[2];
        sha256->BLOCK6 = block[1];
        sha256->BLOCK7 = block[0]; 
    }else{
        sha256->BLOCK8 = block[7];
        sha256->BLOCK9 = block[6];
        sha256->BLOCK10 = block[5];
        sha256->BLOCK11 = block[4];
        sha256->BLOCK12 = block[3];
        sha256->BLOCK13 = block[2];
        sha256->BLOCK14 = block[1];
        sha256->BLOCK15 = block[0];
    }
    
    
}

int EF_SHA256_ready(uint32_t sha256_base){

    EF_SHA256_TYPE* sha256 = (EF_SHA256_TYPE*)sha256_base;
    return (sha256->STATUS & 0x2) >> 1;
}

void EF_SHA256_waitReady(uint32_t sha256_base){

    while(!EF_SHA256_ready(sha256_base));
}

int EF_SHA256_resultValid(uint32_t sha256_base){

    EF_SHA256_TYPE* sha256 = (EF_SHA256_TYPE*)sha256_base;
    return (sha256->STATUS & 0x1);
}

void EF_SHA256_waitResultValid(uint32_t sha256_base){

    while(!EF_SHA256_resultValid(sha256_base));
}

int EF_SHA256_readControl(uint32_t sha256_base){

    EF_SHA256_TYPE* sha256 = (EF_SHA256_TYPE*)sha256_base;
    return (sha256->CTRL);
}

void EF_SHA256_writeControl(uint32_t sha256_base, int control){

    EF_SHA256_TYPE* sha256 = (EF_SHA256_TYPE*)sha256_base;
    sha256->CTRL = control;
}


void EF_SHA256_writeMode(uint32_t sha256_base, bool is265){

    int control = EF_SHA256_readControl(sha256_base);
    if (is265 == true)
        control |= 0x4;
    else
        control &= ~(0x4);
    EF_SHA256_writeControl(sha256_base, control);
}

void EF_SHA256_sendInit(uint32_t sha256_base){

    int control = EF_SHA256_readControl(sha256_base);
    control |= 0x1;
    EF_SHA256_writeControl(sha256_base, control);
    control &= ~(0x1);
    EF_SHA256_writeControl(sha256_base, control);

}

void EF_SHA256_sendNext(uint32_t sha256_base){

    int control = EF_SHA256_readControl(sha256_base);
    control |= 0x2;
    EF_SHA256_writeControl(sha256_base, control);
}

void EF_SHA256_readDigest(uint32_t sha256_base, int *digest){

    EF_SHA256_TYPE* sha256 = (EF_SHA256_TYPE*)sha256_base;
    digest[7] = sha256->DIGEST0;
    digest[6] = sha256->DIGEST1;
    digest[5] = sha256->DIGEST2;
    digest[4] = sha256->DIGEST3;
    digest[3] = sha256->DIGEST4;
    digest[2] = sha256->DIGEST5;
    digest[1] = sha256->DIGEST6;
    digest[0] = sha256->DIGEST7;
}

void EF_SHA256_sendBlockFirst(uint32_t sha256_base, int *blocks0,int *blocks1, bool is265){

    EF_SHA256_writeMode(sha256_base, is265);
    EF_SHA256_writeBlock(sha256_base, blocks1, 1);
    EF_SHA256_writeBlock(sha256_base, blocks0, 0);
    EF_SHA256_sendInit(sha256_base);
    EF_SHA256_waitReady(sha256_base);
}

void EF_SHA256_sendBlock(uint32_t sha256_base, int *blocks0,int *blocks1){

    EF_SHA256_writeBlock(sha256_base, blocks1, 1);
    EF_SHA256_writeBlock(sha256_base, blocks0, 0);
    EF_SHA256_sendNext(sha256_base);
    EF_SHA256_waitReady(sha256_base);
}

void EF_SHA256_waitGetResult(uint32_t sha256_base, int *result){
    
    EF_SHA256_waitResultValid(sha256_base);
    EF_SHA256_readDigest(sha256_base, result);
}

void EF_SHA256_setInterruptMask(uint32_t sha256_base, int mask){
    // bit 0: result valid
    // bit 1: ready
    EF_SHA256_TYPE* sha256 = (EF_SHA256_TYPE*)sha256_base;
    sha256->IM = mask;
}


#endif