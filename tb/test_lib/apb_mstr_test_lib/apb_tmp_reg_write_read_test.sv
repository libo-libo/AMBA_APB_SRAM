class apb_tmp_reg_write_read_test extends apb_base_test;
    `uvm_component_utils(apb_tmp_reg_write_read_test)

    // constructor function
    function new(string name="apb_tmp_reg_write_read_test", uvm_component parent=null);
        super.new(name, parent);
    endfunction: new
    
    // build_phase
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction: build_phase
    
    // connect_phase
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction: connect_phase
    
    // run_phase
    virtual task run_phase(uvm_phase phase);
        int mid_data_val = (2**`DATA_WIDTH)/4;
        int mid_high_data_val = 2*(2**`DATA_WIDTH)/4;
        int high_data_val = 3*(2**`DATA_WIDTH)/4;
        
        super.run_phase(phase);        
        phase.raise_objection(this);
            // Write all memories with low range tmp data
            wr_data_2_mem(1, 1, 0, 0);
            wr_data_2_mem(2, 2, 0, 0);
            // read all memories after write
            rd_data_4m_mem(1, 0);
        phase.drop_objection(this);
    endtask: run_phase
    
endclass: apb_tmp_reg_write_read_test
