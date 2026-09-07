`timescale 1ns/1ps

module smart_home_light (
    input  wire clk,
    input  wire reset,

    // Master power switch
    input  wire master_switch,

    // 1 = automatic mode, 0 = manual mode
    input  wire auto_mode,

    // Sensors
    input  wire motion_detected,
    input  wire dark_condition,

    // Manual light switch
    input  wire manual_switch,

    // Light output
    output reg light_on
);

    always @(posedge clk or posedge reset) begin

        if (reset) begin
            light_on <= 1'b0;
        end

        else begin

            // Master switch OFF
            if (!master_switch) begin
                light_on <= 1'b0;
            end

            // Automatic mode
            else if (auto_mode) begin

                // Turn light ON when motion is detected
                // and the environment is dark
                if (motion_detected && dark_condition)
                    light_on <= 1'b1;
                else
                    light_on <= 1'b0;

            end

            // Manual mode
            else begin

                light_on <= manual_switch;

            end
        end
    end

endmodule
