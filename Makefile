SOURCE 				= HDMI_Top.v  HDMI_Timing.v
BENCH_SOURCE 	= sim_HDMI.v
WAVE_SOURCE		=	HDMI_Top.vcd
OUTPUT 				=	output.out 


all: $(SOURCE) $(BENCH_SOURCE)
	iverilog -o $(OUTPUT) $(SOURCE) $(BENCH_SOURCE) 
run: $(OUTPUT)
	./$(OUTPUT)
view:$(WAVE_SOURCE)
	open -a gtkwave $(WAVE_SOURCE)
clean:
	rm -f *.out *.vcd
