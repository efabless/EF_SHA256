from uvm.base.uvm_component import UVMComponent
from uvm.macros import uvm_component_utils
from uvm.tlm1.uvm_analysis_port import UVMAnalysisImp
from uvm.base.uvm_object_globals import UVM_HIGH, UVM_LOW, UVM_MEDIUM
from uvm.macros import uvm_component_utils, uvm_fatal, uvm_info
from uvm.base.uvm_config_db import UVMConfigDb
from uvm.tlm1.uvm_analysis_port import UVMAnalysisExport
import cocotb
from EF_UVM.ref_model.ref_model import ref_model
from EF_UVM.bus_env.bus_item import bus_item
from cocotb.triggers import Event
import hashlib


class sha256_ref_model(ref_model):
    """
    The reference model is a crucial element within the top-level verification environment, designed to validate the functionality and performance of both the IP (Intellectual Property) and the bus system. Its primary role is to act as a representative or mimic of the actual hardware components, including the IP and the bus. Key features and functions of the reference model include:
    1) Input Simulation: The reference model is capable of receiving the same inputs that would be provided to the actual IP and bus via connection with the monitors of the bus and IP.
    2) Functional Emulation: It emulates the behavior and responses of the IP and bus under test. By replicating the operational characteristics of these components, the reference model serves as a benchmark for expected performance and behavior.
    3) Output Generation: Upon receiving inputs, the reference model processes them in a manner akin to the real hardware, subsequently generating expected outputs. These outputs are essential for comparison in the verification process.
    4) Interface with Scoreboard: The outputs from the reference model, representing the expected results, are forwarded to the scoreboard. The scoreboard then compares these expected results with the actual outputs from the IP and bus for verification.
    5)Register Abstraction Layer (RAL) Integration: The reference model includes a RAL model that mirrors the register values of the RTL, ensuring synchronization between expected and actual register states. This model facilitates register-level tests and error detection, offering accessible and up-to-date register values for other verification components. It enhances the automation and coverage of register testing, playing a vital role in ensuring the accuracy and comprehensiveness of the verification process.
    """

    def __init__(self, name="sha256_ref_model", parent=None):
        super().__init__(name, parent)
        self.tag = name
        self.ris_reg = 0
        self.mis_reg = 0
        self.irq = 0
        self.mis_changed = Event()
        self.icr_changed = Event()
        self.reset()
       

    def reset(self):
        self.blocks = {"BLOCK0":0, "BLOCK1":0, "BLOCK2":0, "BLOCK3":0, "BLOCK4":0, "BLOCK5":0, "BLOCK6":0, "BLOCK7":0, "BLOCK8":0, "BLOCK9":0, "BLOCK10":0, "BLOCK11":0, "BLOCK12":0, "BLOCK13":0, "BLOCK14":0, "BLOCK15":0}
        self.digests = {"DIGEST0":0, "DIGEST1":0, "DIGEST2":0, "DIGEST3":0, "DIGEST4":0, "DIGEST5":0, "DIGEST6":0, "DIGEST7":0}
        self.full_txt = 0
        self.mode = "sha224"
        
    def build_phase(self, phase):
        
        super().build_phase(phase)
        # Here adding any initialize for user classes for the model
        self.blocks_address = {}
        for block in self.regs.reg_name_to_address.keys():
            if "BLOCK" in block:
                self.blocks_address[self.regs.reg_name_to_address[block]] = block
        uvm_info(self.tag, "Blocks address: " + str(self.blocks_address), UVM_LOW)

        self.digest_address = {}
        for digest in self.regs.reg_name_to_address.keys():
            if "DIGEST" in digest:
                self.digest_address[self.regs.reg_name_to_address[digest]] = digest
        uvm_info(self.tag, "Digest address: " + str(self.digest_address), UVM_LOW)

    async def run_phase(self, phase):
        await super().run_phase(phase)
        # Here add the log to run when simulation starts

        # Checking for interrupts should be run as a concurrent coroutine
        await cocotb.start(self.send_irq_tr())
        await cocotb.start(self.clear_ris_reg())

    def write_bus(self, tr):
        # Called when new transaction is received from the bus monitor
        # TODO: update the following logic to determine what to do with the received transaction
        uvm_info(
            self.tag,
            " Ref model recieved from bus monitor: " + tr.convert2string(),
            UVM_HIGH,
        )
        if tr.kind == bus_item.RESET:
            self.bus_bus_export.write(tr)
            uvm_info("Ref model", "reset from ref model", UVM_LOW)
            # TODO: write logic needed when reset is received
            self.reset()
            self.bus_bus_export.write(tr)
            return
        if tr.kind == bus_item.WRITE:
            # TODO: write logic needed when write transaction is received
            # For example, to write the same value to the same resgiter uncomment the following lines
            # self.regs.write_reg_value(tr.addr, tr.data)
            # self.bus_bus_export.write(tr) # this is output to the scoreboard
            if tr.addr in self.blocks_address.keys():
                self.blocks[self.blocks_address[tr.addr]] = tr.data
            elif tr.addr == self.regs.reg_name_to_address["CTRL"]:
                if tr.data & 0b100 == 0b100:
                    self.mode = "sha256"
                else:
                    self.mode = "sha224"
                # init
                if tr.data & 0b1 == 0b1:
                    self.full_txt = hex(self.blocks["BLOCK15"])[2:] + hex(self.blocks["BLOCK14"])[2:] + hex(self.blocks["BLOCK13"])[2:] + hex(self.blocks["BLOCK12"])[2:] + hex(self.blocks["BLOCK11"])[2:] + hex(self.blocks["BLOCK10"])[2:] + hex(self.blocks["BLOCK9"])[2:] + hex(self.blocks["BLOCK8"])[2:] + hex(self.blocks["BLOCK7"])[2:] + hex(self.blocks["BLOCK6"])[2:] + hex(self.blocks["BLOCK5"])[2:] + hex(self.blocks["BLOCK4"])[2:] + hex(self.blocks["BLOCK3"])[2:] + hex(self.blocks["BLOCK2"])[2:] + hex(self.blocks["BLOCK1"])[2:] + hex(self.blocks["BLOCK0"])[2:]
                    self.update_digests()
                # next
                if tr.data & 0b10 == 0b10:
                    self.full_txt = hex(self.blocks["BLOCK15"])[2:] + hex(self.blocks["BLOCK14"])[2:] + hex(self.blocks["BLOCK13"])[2:] + hex(self.blocks["BLOCK12"])[2:] + hex(self.blocks["BLOCK11"])[2:] + hex(self.blocks["BLOCK10"])[2:] + hex(self.blocks["BLOCK9"])[2:] + hex(self.blocks["BLOCK8"])[2:] + hex(self.blocks["BLOCK7"])[2:] + hex(self.blocks["BLOCK6"])[2:] + hex(self.blocks["BLOCK5"])[2:] + hex(self.blocks["BLOCK4"])[2:] + hex(self.blocks["BLOCK3"])[2:] + hex(self.blocks["BLOCK2"])[2:] + hex(self.blocks["BLOCK1"])[2:] + hex(self.blocks["BLOCK0"])[2:] + self.full_txt
                    self.update_digests()
            # check if the write register is icr , set the icr changed event
            if tr.addr == self.regs.reg_name_to_address["icr"] and tr.data != 0:
                self.icr_changed.set()
            pass
        elif tr.kind == bus_item.READ:
            # TODO: write logic needed when read transaction is received
            # For example, to read the same resgiter uncomment the following lines
            data = self.regs.read_reg_value(tr.addr)
            td = tr.do_clone()
            if tr.addr in self.digest_address.keys():
                td.data = self.digests[self.digest_address[tr.addr]]
            elif tr.addr == self.regs.reg_name_to_address["STATUS"] :
                pass
            else:
                td.data = data
            self.bus_bus_export.write(td) # this is output to the scoreboard
        self.update_interrupt_regs()
    
    def update_digests(self):
        if self.mode == "sha256":
            hasher = hashlib.sha256()
        elif self.mode == "sha224":
            hasher = hashlib.sha224()
        else:
            uvm_fatal("REF_MODEL", "Invalid sha mode")
        # convert to hex
        full_int = int(self.full_txt, 16)
        hasher.update(full_int.to_bytes((full_int.bit_length() + 7) // 8, 'big'))
        hashed_val = hasher.hexdigest()
        uvm_info("REF_MODEL", "full txt: " + self.full_txt, UVM_LOW)
        uvm_info("REF_MODEL", f"full int: {hex(full_int)}", UVM_LOW)
        uvm_info("REF_MODEL", "hashed val: " + hashed_val, UVM_LOW)
            
    def write_ip(self, tr):
        # Called when new transaction is received from the ip monitor
        # TODO: write what to do when new transaction ip transaction is received
        uvm_info(
            self.tag,
            "Ref model recieved from ip monitor: " + tr.convert2string(),
            UVM_HIGH,
        )

        # Update interrupts when a new ip transaction is received
        self.set_ris_reg()
        self.update_interrupt_regs()
        # Here the ref model should predict the transaction and send it to scoreboard
        # self.ip_export.write(td) # this is output ro scoreboard

    def set_ris_reg(self):
        # TODO: update this function to update the value of 'self.ris_reg' according to the ip transaction
        # For example:
        # rx_fifo_threshold = self.regs.read_reg_value("RXFIFOT")
        # if self.fifo_rx.qsize() > rx_fifo_threshold:
        #     self.ris_reg |= 0x2
        pass

    async def clear_ris_reg(self):
        # This coroutine runs concurrently it waits for icr_changed event then update interrupt registers
        while True:
            await self.icr_changed.wait()
            icr_reg = self.regs.read_reg_value("icr")
            mask = ~icr_reg
            self.ris_reg = self.ris_reg & mask
            self.update_interrupt_regs()
            self.regs.write_reg_value("icr", 0, force_write=True)  # clear icr register
            self.icr_changed.clear()

    def update_interrupt_regs(self):
        # This function updates ris and mis with new values and set mis changed event if mis has a new value
        self.regs.write_reg_value("ris", self.ris_reg, force_write=True)
        im_reg = self.regs.read_reg_value("im")
        mis_reg_new = self.ris_reg & im_reg
        uvm_info(
            self.tag,
            f" Update interrupts :  im =  {im_reg:X}, ris =  {self.ris_reg:X}, mis = {mis_reg_new:X}",
            UVM_LOW,
        )
        if mis_reg_new != self.mis_reg:
            self.mis_changed.set()
        self.mis_reg = mis_reg_new
        self.regs.write_reg_value("mis", self.mis_reg, force_write=True)

    async def send_irq_tr(self):
        # This coroutine waits for mis_changed event, create an interrupt transaction, then send it to scoreboard for comparison
        # if trg_irq = 1 means that irq changed from low to high, if it is 0,  it means irq changed from high to low
        while True:
            await self.mis_changed.wait()
            irq_new = 1 if self.mis_reg else 0
            if irq_new and not self.irq:  # irq changed from low to high
                self.irq = 1
                tr = bus_irq_item.type_id.create("tr", self)
                tr.trg_irq = 1
                self.bus_irq_export.write(tr)
            elif not irq_new and self.irq:  # irq changed from high to low
                self.irq = 0
                tr = bus_irq_item.type_id.create("tr", self)
                tr.trg_irq = 0
                self.bus_irq_export.write(tr)

            self.mis_changed.clear()


uvm_component_utils(sha256_ref_model)
