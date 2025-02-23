from uvm.seq import UVMSequence
from uvm.macros.uvm_object_defines import uvm_object_utils
from uvm.macros.uvm_message_defines import uvm_fatal
from uvm.base.uvm_config_db import UVMConfigDb
from EF_UVM.bus_env.bus_seq_lib.bus_seq_base import bus_seq_base
from cocotb.triggers import Timer
from uvm.macros.uvm_sequence_defines import uvm_do_with, uvm_do
import random
from sha256_seq_lib.sha256_config_seq import sha256_config_seq


class sha256_bus_seq(sha256_config_seq):
    # use this sequence write or read from register by the bus interface
    # this sequence should be connected to the bus sequencer in the testbench
    # you should create as many sequences as you need not only this one
    def __init__(self, name="sha256_bus_seq"):
        super().__init__(name)

    async def body(self):
        await super().body()
        block00 = [0x6b900001, 0x496e2074, 0x68652061, 0x72656120, 0x6f662049, 0x6f542028, 0x496e7465, 0x726e6574]
        block01 = [0x206f6620, 0x5468696e, 0x6773292c, 0x206d6f72, 0x6520616e, 0x64206d6f, 0x7265626f, 0x6f6d2c20]
        block10 = [0x69742068, 0x61732062, 0x65656e20, 0x6120756e, 0x69766572, 0x73616c20, 0x636f6e73, 0x656e7375]
        block11 = [0x73207468, 0x61742064, 0x61746120, 0x69732074, 0x69732061, 0x206e6577, 0x20746563, 0x686e6f6c]
        block20 = [0x6f677920, 0x74686174, 0x20696e74, 0x65677261, 0x74657320, 0x64656365, 0x6e747261, 0x6c697a61]
        block21 = [0x74696f6e, 0x2c496e20, 0x74686520, 0x61726561, 0x206f6620, 0x496f5420, 0x28496e74, 0x65726e65]
        block30 = [0x74206f66, 0x20546869, 0x6e677329, 0x2c206d6f, 0x72652061, 0x6e64206d, 0x6f726562, 0x6f6f6d2c]
        block31 = [0x20697420, 0x68617320, 0x6265656e, 0x20612075, 0x6e697665, 0x7273616c, 0x20636f6e, 0x73656e73]
        block40 = [0x75732074, 0x68617420, 0x64617461, 0x20697320, 0x74697320, 0x61206e65, 0x77207465, 0x63686e6f]
        block41 = [0x6c6f6779, 0x20746861, 0x7420696e, 0x74656772, 0x61746573, 0x20646563, 0x656e7472, 0x616c697a]
        block50 = [0x6174696f, 0x6e2c496e, 0x20746865, 0x20617265, 0x61206f66, 0x20496f54, 0x2028496e, 0x7465726e]
        block51 = [0x6574206f, 0x66205468, 0x696e6773, 0x292c206d, 0x6f726520, 0x616e6420, 0x6d6f7265, 0x626f6f6d]
        block60 = [0x2c206974, 0x20686173, 0x20626565, 0x6e206120, 0x756e6976, 0x65727361, 0x6c20636f, 0x6e73656e]
        block61 = [0x73757320, 0x74686174, 0x20646174, 0x61206973, 0x20746973, 0x2061206e, 0x65772074, 0x6563686e]
        block70 = [0x6f6c6f67, 0x79207468, 0x61742069, 0x6e746567, 0x72617465, 0x73206465, 0x63656e74, 0x72616c69]
        block71 = [0x7a617469, 0x6f6e2c49, 0x6e207468, 0x65206172, 0x6561206f, 0x6620496f, 0x54202849, 0x6e746572]
        block80 = [0x6e657420, 0x6f662054, 0x68696e67, 0x73292c20, 0x6d6f7265, 0x20616e64, 0x206d6f72, 0x65800000]
        block81 = [0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x000010e8]

        block0 = {
            "BLOCK0": block01[7],
            "BLOCK1": block01[6],
            "BLOCK2": block01[5],
            "BLOCK3": block01[4],
            "BLOCK4": block01[3],
            "BLOCK5": block01[2],
            "BLOCK6": block01[1],
            "BLOCK7": block01[0],
            "BLOCK8": block00[7],
            "BLOCK9": block00[6],
            "BLOCK10": block00[5],
            "BLOCK11": block00[4],
            "BLOCK12": block00[3],
            "BLOCK13": block00[2],
            "BLOCK14": block00[1],
            "BLOCK15": block00[0]}
        block1 = {
            "BLOCK0": block11[7],
            "BLOCK1": block11[6],
            "BLOCK2": block11[5],
            "BLOCK3": block11[4],
            "BLOCK4": block11[3],
            "BLOCK5": block11[2],
            "BLOCK6": block11[1],
            "BLOCK7": block11[0],
            "BLOCK8": block10[7],
            "BLOCK9": block10[6],
            "BLOCK10": block10[5],
            "BLOCK11": block10[4],
            "BLOCK12": block10[3],
            "BLOCK13": block10[2],
            "BLOCK14": block10[1],
            "BLOCK15": block10[0]}
        block2 = {
            "BLOCK0": block21[7],
            "BLOCK1": block21[6],
            "BLOCK2": block21[5],
            "BLOCK3": block21[4],
            "BLOCK4": block21[3],
            "BLOCK5": block21[2],
            "BLOCK6": block21[1],
            "BLOCK7": block21[0],
            "BLOCK8": block20[7],
            "BLOCK9": block20[6],
            "BLOCK10": block20[5],
            "BLOCK11": block20[4],
            "BLOCK12": block20[3],
            "BLOCK13": block20[2],
            "BLOCK14": block20[1],
            "BLOCK15": block20[0]}
        block3 = {
            "BLOCK0": block31[7],
            "BLOCK1": block31[6],
            "BLOCK2": block31[5],
            "BLOCK3": block31[4],
            "BLOCK4": block31[3],
            "BLOCK5": block31[2],
            "BLOCK6": block31[1],
            "BLOCK7": block31[0],
            "BLOCK8": block30[7],
            "BLOCK9": block30[6],
            "BLOCK10": block30[5],
            "BLOCK11": block30[4],
            "BLOCK12": block30[3],
            "BLOCK13": block30[2],
            "BLOCK14": block30[1],
            "BLOCK15": block30[0]}        
        block4 = {
            "BLOCK0": block41[7],
            "BLOCK1": block41[6],
            "BLOCK2": block41[5],
            "BLOCK3": block41[4],
            "BLOCK4": block41[3],
            "BLOCK5": block41[2],
            "BLOCK6": block41[1],
            "BLOCK7": block41[0],
            "BLOCK8": block40[7],
            "BLOCK9": block40[6],
            "BLOCK10": block40[5],
            "BLOCK11": block40[4],
            "BLOCK12": block40[3],
            "BLOCK13": block40[2],
            "BLOCK14": block40[1],
            "BLOCK15": block40[0]}
        block5 = {
            "BLOCK0": block51[7],
            "BLOCK1": block51[6],
            "BLOCK2": block51[5],
            "BLOCK3": block51[4],
            "BLOCK4": block51[3],
            "BLOCK5": block51[2],
            "BLOCK6": block51[1],
            "BLOCK7": block51[0],
            "BLOCK8": block50[7],
            "BLOCK9": block50[6],
            "BLOCK10": block50[5],
            "BLOCK11": block50[4],
            "BLOCK12": block50[3],
            "BLOCK13": block50[2],
            "BLOCK14": block50[1],
            "BLOCK15": block50[0]}
        block6 = {
            "BLOCK0": block61[7],
            "BLOCK1": block61[6],
            "BLOCK2": block61[5],
            "BLOCK3": block61[4],
            "BLOCK4": block61[3],
            "BLOCK5": block61[2],
            "BLOCK6": block61[1],
            "BLOCK7": block61[0],
            "BLOCK8": block60[7],
            "BLOCK9": block60[6],
            "BLOCK10": block60[5],
            "BLOCK11": block60[4],
            "BLOCK12": block60[3],
            "BLOCK13": block60[2],
            "BLOCK14": block60[1],
            "BLOCK15": block60[0]}
        block7 = {
            "BLOCK0": block71[7],
            "BLOCK1": block71[6],
            "BLOCK2": block71[5],
            "BLOCK3": block71[4],
            "BLOCK4": block71[3],
            "BLOCK5": block71[2],
            "BLOCK6": block71[1],
            "BLOCK7": block71[0],
            "BLOCK8": block70[7],
            "BLOCK9": block70[6],
            "BLOCK10": block70[5],
            "BLOCK11": block70[4],
            "BLOCK12": block70[3],
            "BLOCK13": block70[2],
            "BLOCK14": block70[1],
            "BLOCK15": block70[0]}
        block8 = {
            "BLOCK0": block81[7],
            "BLOCK1": block81[6],
            "BLOCK2": block81[5],
            "BLOCK3": block81[4],
            "BLOCK4": block81[3],
            "BLOCK5": block81[2],
            "BLOCK6": block81[1],
            "BLOCK7": block81[0],
            "BLOCK8": block80[7],
            "BLOCK9": block80[6],
            "BLOCK10": block80[5],
            "BLOCK11": block80[4],
            "BLOCK12": block80[3],
            "BLOCK13": block80[2],
            "BLOCK14": block80[1],
            "BLOCK15": block80[0]}
        await self.send_firstBlock(block0)
        await self.send_Block(block1)
        await self.send_Block(block2)
        await self.send_Block(block3)
        await self.send_Block(block4)
        await self.send_Block(block5)
        await self.send_Block(block6)
        await self.send_Block(block7)
        await self.send_Block(block8)
        await self.waitResultValid()
        await self.read_digest()
        
        
        
    async def send_firstBlock(self, blocks_dict={}):
        await self.set_length(is_128=False)
        await self.writeBlock(blocks_dict)
        await self.set_init()
        await self.waitReady()
    
    async def send_Block(self, blocks_dict={}):
        await self.writeBlock(blocks_dict)
        await self.set_next()
        await self.waitReady()
        
        
    async def writeBlock(self, blocks_dict={}):
        for key, value in blocks_dict.items():
            await self.send_req(is_write=True, reg=key, data_value=value)

uvm_object_utils(sha256_bus_seq)
