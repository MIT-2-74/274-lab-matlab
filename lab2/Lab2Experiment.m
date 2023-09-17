function output_data = Lab2Experiment()
    figure(1); clf;       % Create an empty figure to update later
    sp1 = subplot(311);
    h1 = plot([0],[0]);
    h1.XData = []; h1.YData = [];
    ylabel('position (rad)');
    title('Position');
    
    sp2 = subplot(312);
    h2 = plot([0],[0]);
    h2.XData = []; h2.YData = [];
    ylabel('velocity (rad/s)');
    title('Velocity');
    
    sp3 = subplot(313);
    h3 = plot([0],[0]);
    h3.XData = []; h3.YData = [];
    ylabel('current (A)');
    title('Current');

    xlabel("time (s)");
    linkaxes([sp1 sp2 sp3], 'x');
    
    % This function will get called any time there is new data from
    % the Nucleo board. Data comes in blocks, rather than one at a time.
    function data_callback(new_data)
        t = new_data(:,1);   % time
        pos = new_data(:,2); % position
        vel = new_data(:,3); % velocity
        curr = new_data(:,4); % current
        N = length(pos);
        
        h1.XData(end+1:end+N) = t;   % Update subplot 1
        h1.YData(end+1:end+N) = pos;
        h2.XData(end+1:end+N) = t;   % Update subplot 2
        h2.YData(end+1:end+N) = vel;
        h3.XData(end+1:end+N) = t;   % Update subplot 3
        h3.YData(end+1:end+N) = curr;

    end
    
    frdm_ip  = '192.168.1.100';       % Nucleo board ip
    frdm_port = 11223;                % Nucleo board port  
    params.callback = @data_callback; % callback function
    params.timeout  = 2;              % end of experiment timeout
    
    % The example program provided takes two arguments
    d1 = 0.7;
    d2 = 0.3;
    input = [d1 d2];    % input sent to Nucleo board
    output_size = 4;    % number of outputs expected
    
    output_data = RunExperiment(frdm_ip,frdm_port,input,output_size,params);
end
