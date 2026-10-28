#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vsinegen.h"
#include "vbuddy.cpp"

#define MAX_SIM_CYC 1000000
#define ADDRESS_WIDTH 8
#define ROM_SZ 256


int main(int argc, char **argv, char **env) {
    int simcyc;
    int tick;

    Verilated::commandArgs(argc, argv);

    Vsinegen* top = new Vsinegen;

    // Initialise waveform tracing
    Verilated::traceEverOn(true);

    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("sinegen.vcd");

    // Connect to Vbuddy
    if (vbdOpen() != 1) {
        return -1;
    }

    vbdHeader("L2T1: SigGen");

    // Initialise simulation inputs
    top->clk = 1;
    top->rst = 0;
    top->en = 1;
    top->incr = 1;

    for (simcyc = 0; simcyc < MAX_SIM_CYC; simcyc++) {

        // Each clock cycle contains two transitions
        for (tick = 0; tick < 2; tick++) {
            tfp->dump(2 * simcyc + tick); // records the signal values in the waveform file
            top->clk = !top->clk;
            top->eval();
        }
    
        // Plot the ROM output on Vbuddy
        vbdPlot(int(top->dout), 0, 255);

        // Display the current simulation cycle
        vbdCycle(simcyc);
        
        if (Verilated::gotFinish() || vbdGetkey() == 'q') {
            break;
        }
    }
    
    vbdClose();

    tfp->close();
    delete tfp;
    delete top;

    return 0;
}
