# SW_SHA256
Bus wrappers for hardware implementation of the SHA-256 cryptographic hash function. The rtl is based on [this repo](https://github.com/secworks/sha256) 

## I/O Registers 
|  Offset  | Size |  Register  | Description |
|----------|------|------------|-------------|
|0x00       |  8   | Status Register  | bit 0: digest is valid <br> bit 1: ready 
|0x04       |  8   | Control Register | bit 0: Initial bit (init) <br> bit 1: Next bit <br> bit 2: Mode bit; “0” means SHA224 “1” means SHA256 
|0x08       | 32   | Block Register 0 | Contains the bits 31-0 of the input block value
|0x0C       | 32   | Block Register 1 | Contains the bits 63-32 of the input block value
|0x10       | 32   | Block Register 2 | Contains the bits 95-64 of the input block value
|0x14       | 32   | Block Register 3 | Contains the bits 127-96 of the input block value
|0x18       | 32   | Block Register 4 | Contains the bits 159-128 of the input block value
|0x1C       | 32   | Block Register 5 | Contains the bits 191-160 of the input block value
|0x20       | 32   | Block Register 6 | Contains the bits 223-192 of the input block value
|0x24       | 32   | Block Register 7 | Contains the bits 255-224 of the input block value
|0x28       | 32   | Block Register 8 | Contains the bits 287-256 of the input block value
|0x2C       | 32   | Block Register 9 | Contains the bits 319-288 of the input block value
|0x30       | 32   | Block Register 10| Contains the bits 351-320 of the input block value
|0x34       | 32   | Block Register 11| Contains the bits 383-352 of the input block value
|0x38       | 32   | Block Register 12| Contains the bits 415-384 of the input block value
|0x3C       | 32   | Block Register 13| Contains the bits 447-416 of the input block value
|0x40       | 32   | Block Register 14| Contains the bits 479-448 of the input block value
|0x44       | 32   | Block Register 15| Contains the bits 512-480 of the input block value
|0x48       | 32   | Digest Register 0| Contains the bits 31-0 of the input digest value
|0x4C       | 32   | Digest Register 1| Contains the bits 63-32 of the input digest value
|0x50       | 32   | Digest Register 2| Contains the bits 95-64 of the input digest value
|0x54       | 32   | Digest Register 3| Contains the bits 127-96 of the input digest value
|0x58       | 32   | Digest Register 4| Contains the bits 159-128 of the input digest value
|0x5C       | 32   | Digest Register 5| Contains the bits 191-160 of the input digest value
|0x60       | 32   | Digest Register 6| Contains the bits 223-192 of the input digest value
|0x64       | 32   | Digest Register 7| Contains the bits 255-224 of the input digest value
|0xF00      | 2    | Interrupt Clear (IC) Register | It is used to clear an interrupt flag in RIS as well as MIS registers; it is required to write ‘1’ to the corresponding bit in the IC register.
|0xF04      | 2    | Raw Interrupts Status (RIS) Register | Contains the interrupt flags status before masking.
|0xF08      | 2    | Interrupts Mask (IM) Register | Disabling/Enabling an interrupt source.
|0xF0C      | 2    | Masked Interrupts Status (MIS) Register | Contains the interrupt flags status after masking.

## Interrupts 
The following table gives the bit definitions for the IC, RIS, IM and MIS registers

|Bit | Meaning|
|----|--------|
|0 | Result is valid
|1 | Ready to start

