`timescale 1ns/1ps

module smart_home_light_tb;

    reg clk;
    reg reset;

    reg master_switch;
    reg auto_mode;

    reg motion_detected;
    reg dark_condition;

    reg manual_switch;

    wire light_on;

    // ------------------------------------------------
    // Device Under Test
    // ------------------------------------------------

    smart_home_light dut (

        .clk(clk),
        .reset(reset),

        .master_switch(master_switch),
        .auto_mode(auto_mode),

        .motion_detected(motion_detected),
        .dark_condition(dark_condition),

        .manual_switch(manual_switch),

        .light_on(light_on)
    );

    // ------------------------------------------------
    // Clock generation
    // ------------------------------------------------

    initial begin
        clk = 1'b0;

        forever #5 clk = ~clk;
    end

    // ------------------------------------------------
    // Test cases
    // ------------------------------------------------

    initial begin

        // Initial values
        reset           = 1'b1;
        master_switch   = 1'b0;
        auto_mode       = 1'b0;
        motion_detected = 1'b0;
        dark_condition  = 1'b0;
        manual_switch   = 1'b0;

        #20;

        reset = 1'b0;

        // ============================================
        // TEST 1: Master switch OFF
        // ============================================

        $display("-----------------------------------------");
        $display("TEST 1: MASTER SWITCH OFF");
        $display("-----------------------------------------");

        master_switch = 1'b0;
        auto_mode = 1'b1;
        motion_detected = 1'b1;
        dark_condition = 1'b1;

        #20;

        $display("Light = %b", light_on);


        // ============================================
        // TEST 2: Automatic mode - dark + motion
        // ============================================

        $display("-----------------------------------------");
        $display("TEST 2: AUTO MODE - DARK + MOTION");
        $display("-----------------------------------------");

        master_switch = 1'b1;
        auto_mode = 1'b1;
        motion_detected = 1'b1;
        dark_condition = 1'b1;

        #20;

        $display("Motion = %b | Dark = %b | Light = %b",
                 motion_detected,
                 dark_condition,
                 light_on);


        // ============================================
        // TEST 3: Automatic mode - no motion
        // ============================================

        $display("-----------------------------------------");
        $display("TEST 3: AUTO MODE - NO MOTION");
        $display("-----------------------------------------");

        motion_detected = 1'b0;
        dark_condition = 1'b1;

        #20;

        $display("Motion = %b | Dark = %b | Light = %b",
                 motion_detected,
                 dark_condition,
                 light_on);


        // ============================================
        // TEST 4: Automatic mode - daylight
        // ============================================

        $display("-----------------------------------------");
        $display("TEST 4: AUTO MODE - DAYLIGHT");
        $display("-----------------------------------------");

        motion_detected = 1'b1;
        dark_condition = 1'b0;

        #20;

        $display("Motion = %b | Dark = %b | Light = %b",
                 motion_detected,
                 dark_condition,
                 light_on);


        // ============================================
        // TEST 5: Manual mode - light ON
        // ============================================

        $display("-----------------------------------------");
        $display("TEST 5: MANUAL MODE - LIGHT ON");
        $display("-----------------------------------------");

        auto_mode = 1'b0;
        manual_switch = 1'b1;

        #20;

        $display("Manual Switch = %b | Light = %b",
                 manual_switch,
                 light_on);


        // ============================================
        // TEST 6: Manual mode - light OFF
        // ============================================

        $display("-----------------------------------------");
        $display("TEST 6: MANUAL MODE - LIGHT OFF");
        $display("-----------------------------------------");

        manual_switch = 1'b0;

        #20;

        $display("Manual Switch = %b | Light = %b",
                 manual_switch,
                 light_on);


        // ============================================
        // TEST 7: Master switch OFF
        // ============================================

        $display("-----------------------------------------");
        $display("TEST 7: MASTER SWITCH OFF");
        $display("-----------------------------------------");

        master_switch = 1'b0;
        manual_switch = 1'b1;

        #20;

        $display("Master Switch = %b | Light = %b",
                 master_switch,
                 light_on);


        // ============================================
        // Finish
        // ============================================

        $display("-----------------------------------------");
        $display("SIMULATION COMPLETED");
        $display("-----------------------------------------");

        #10;

        $finish;

    end

    // ------------------------------------------------
    // Monitor
    // ------------------------------------------------

    initial begin

        $monitor(
            "Time=%0t | Master=%b | Auto=%b | Motion=%b | Dark=%b | Manual=%b | Light=%b",
            $time,
            master_switch,
            auto_mode,
            motion_detected,
            dark_condition,
            manual_switch,
            light_on
        );

    end

endmodule
