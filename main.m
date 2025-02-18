addpath('./source_coding/')

[encoded, fs] = quantize_downsample('hello.wav', 8, 8000);

encoded_bits = encoded_to_bits(encoded);
disp(encoded_bits);


decoded = dequantize_upsample(encoded,8,8000);

plot_signals('hello.wav', 8, 8000);

function plot_signals(audio_file, num_bits, target_fs)
    % Load the original audio
    [x, fs] = audioread(audio_file);

    % Convert to mono if stereo
    if size(x, 2) > 1
        x = mean(x, 2);
    end
    
    % Resample to target sampling rate (e.g., 8 kHz or 4 kHz)
    x_resampled = resample(x, target_fs, fs);
    fs = target_fs;
    
    % Quantize the signal (compression)
    max_val = 2^(num_bits - 1) - 1;
    x_quantized = round(x_resampled * max_val); % Quantize to num_bits
    encoded = int8(x_quantized); % Store as 8-bit values
    
    % Decode (decompression)
    decoded = double(encoded) / max_val;
    
    % Create time vectors for plotting (use a small window of data for visualization)
    t_raw = (0:length(x_resampled)-1) / fs;
    t_encoded = (0:length(encoded)-1) / fs;
    t_decoded = (0:length(decoded)-1) / fs;
    
    % Plot the original, encoded, and decoded signals
    figure;
    
    % Raw signal plot (after resampling)
    subplot(3,1,1);
    plot(t_raw, x_resampled, 'b');
    title('Raw (Resampled) Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    
    % Encoded signal plot (quantized)
    subplot(3,1,2);
    plot(t_encoded, encoded, 'r');
    title('Encoded (Quantized) Signal');
    xlabel('Time (s)');
    ylabel('Quantized Amplitude');
    
    % Decoded signal plot
    subplot(3,1,3);
    plot(t_decoded, decoded, 'g');
    title('Decoded Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    
    % Display the effective bitrate
    bitrate = fs * num_bits;  % Bitrate calculation
    disp(['Effective Bitrate: ', num2str(bitrate / 1000), ' kbit/s']);
end


