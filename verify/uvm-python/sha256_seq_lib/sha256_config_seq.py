from uvm.seq import UVMSequence
from uvm.macros.uvm_object_defines import uvm_object_utils
from uvm.macros.uvm_message_defines import uvm_fatal
from uvm.base.uvm_config_db import UVMConfigDb
from EF_UVM.bus_env.bus_seq_lib.bus_seq_base import bus_seq_base
from cocotb.triggers import Timer
from uvm.macros.uvm_sequence_defines import uvm_do_with, uvm_do
import random
from uvm.macros import uvm_component_utils, uvm_fatal, uvm_info, uvm_error
from uvm.base.uvm_object_globals import UVM_LOW


class sha256_config_seq(bus_seq_base):
    # use this sequence write or read from register by the bus interface
    # this sequence should be connected to the bus sequencer in the testbench
    # you should create as many sequences as you need not only this one
    def __init__(self, name="sha256_config_seq"):
        super().__init__(name)
        regs_arr = []
        if not UVMConfigDb.get(self, "", "bus_regs", regs_arr):
            uvm_fatal(self.tag, "No json file wrapper regs")
        else:
            self.regs = regs_arr[0]
        self.length = 0

    async def body(self):
        await super().body()       

    async def waitReady(self):
        self.clear_response_queue()
        while True:
            rsp = []
            await self.send_req(is_write=False, reg="STATUS")
            await self.get_response(rsp)
            ris_reg = rsp[0]
            uvm_info(self.tag, f"STATUS value{ris_reg}", UVM_LOW)
            if (
                ris_reg.data & 0b10 == 0b10
                and ris_reg.addr == self.regs.reg_name_to_address["STATUS"]
            ):
                break
           
    async def waitResultValid(self):
        self.clear_response_queue()
        while True:
            rsp = []
            await self.send_req(is_write=False, reg="STATUS")
            await self.get_response(rsp)
            ris_reg = rsp[0]
            uvm_info(self.tag, f"STATUS value{ris_reg}", UVM_LOW)
            if (
                ris_reg.data & 0b1 == 0b1
                and ris_reg.addr == self.regs.reg_name_to_address["STATUS"]
            ):
                break

    async def write_rand_blocks(self):
        for block in random.sample(["BLOCK0", "BLOCK1", "BLOCK2", "BLOCK3", "BLOCK4", "BLOCK5", "BLOCK6", "BLOCK7", "BLOCK8", "BLOCK9", "BLOCK10", "BLOCK11", "BLOCK12", "BLOCK13", "BLOCK14", "BLOCK15"], k=16):
            await self.send_req(is_write=True, reg=block, data_value=random.getrandbits(32))

    async def read_digest(self):
        for result in random.sample(["DIGEST0", "DIGEST1", "DIGEST2", "DIGEST3", "DIGEST4", "DIGEST5", "DIGEST6", "DIGEST7"], k=8):
            await self.send_req(is_write=False, reg=result)

    async def set_length(self, is_128):
        if is_128:
            self.length = 0
            value = self.length << 2
            await self.send_req(is_write=True, reg="CTRL", data_condition=lambda data: data == value)
        else:
            self.length = 1
            value = self.length << 2
            await self.send_req(is_write=True, reg="CTRL", data_condition=lambda data: data == value)

    async def set_init(self):
        value = 1 << 0 | self.length << 2
        await self.send_req(is_write=True, reg="CTRL", data_condition=lambda data: data == value)
        for _ in range(2):
           await self.send_nop()

    async def set_next(self):
        value = 1 << 1 | self.length << 2
        await self.send_req(is_write=True, reg="CTRL", data_condition=lambda data: data == value)
        for _ in range(2):
            await self.send_nop()


uvm_object_utils(sha256_config_seq)
