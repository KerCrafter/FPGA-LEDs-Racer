# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock, Timer
from cocotb.triggers import ClockCycles, RisingEdge

def is_gate_level(dut):
    return dut._name.startswith("gl_")

def skip_in_gl(test_func):
    skip_flag = True
    async def wrapper(dut):
        if is_gate_level(dut) and skip_flag:
            dut._log.info(f"Skipping {test_func.__name__} in gate-level simulation")
            return
        return await test_func(dut)
    return wrapper

@cocotb.test()
async def test_init(dut):
    dut._log.info("Start")

    clock = Clock(dut.clk, 20, unit="ns")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    dut.ui_in.value = 0
    dut.uio_in.value = 0

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value == "00000000"

@cocotb.test()
async def test_blue_ready_to_play(dut):
    dut._log.info("Start")

    clock = Clock(dut.clk, 20, 'ns')
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    await ClockCycles(dut.clk, 10)

    dut._log.info("Blue press button")

    dut.ui_in.value = "00000001"

    dut._log.info("Wait TP_BLUE_READY_TO_PLAY")

    await RisingEdge(dut.tp_update_frame)


    assert dut.tp_blue_ready_to_play.value == 1

@cocotb.test()
async def test_red_ready_to_play(dut):
    dut._log.info("Start")

    clock = Clock(dut.clk, 20, 'ns')
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    await ClockCycles(dut.clk, 10)

    dut._log.info("Red press button")

    dut.ui_in.value = "00000010"

    dut._log.info("Wait TP_RED_READY_TO_PLAY")

    await RisingEdge(dut.tp_update_frame)

    assert dut.tp_red_ready_to_play.value == 1

@cocotb.test()
async def test_green_ready_to_play(dut):
    dut._log.info("Start")

    clock = Clock(dut.clk, 20, 'ns')
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    await ClockCycles(dut.clk, 10)

    dut._log.info("Green press button")

    dut.ui_in.value = "00000100"

    dut._log.info("Wait TP_GREEN_READY_TO_PLAY")

    await RisingEdge(dut.tp_update_frame)

    assert dut.tp_green_ready_to_play.value == 1

@cocotb.test()
async def test_yellow_ready_to_play(dut):
    dut._log.info("Start")

    clock = Clock(dut.clk, 20, 'ns')
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    await ClockCycles(dut.clk, 10)

    dut._log.info("Yellow press button")

    dut.ui_in.value = "00001000"

    dut._log.info("Wait TP_YELLOW_READY_TO_PLAY")

    await RisingEdge(dut.tp_update_frame)

    assert dut.tp_yellow_ready_to_play.value == 1

@cocotb.test()
@skip_in_gl
async def test_blue_and_red_ready_to_play(dut):
    dut._log.info("Start")

    clock = Clock(dut.clk, 20, 'ns')
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    await ClockCycles(dut.clk, 10)

    dut._log.info("Blue and Red press button")

    dut.ui_in.value = "00000011"

    dut._log.info("Wait TP_CUR_SCREEN change")

    await RisingEdge(dut.tp_cur_screen)

    assert dut.tp_cur_screen.value == 1
