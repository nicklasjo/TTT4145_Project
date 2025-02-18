function [encoded, fs] = quantize_downsample(audio_file, num_bits, target_fs)
    % Load speech file
    [x, fs] = audioread(audio_file);
    %sound(x,fs)
    % Convert to mono if stereo
    if size(x, 2) > 1
        x = mean(x, 2);
    end

    % Resample to target sampling rate (e.g., 8 kHz or 4 kHz)
    x = resample(x, target_fs, fs);
    fs = target_fs;

    % Scale to integer range (quantization)
    max_val = 2^(num_bits - 1) - 1;
    x = round(x * max_val); % Quantize to num_bits
    encoded = int8(x); % Store as 8-bit values (adjust for lower bit-depth)
    % Display effective bitrate
    bitrate = fs * num_bits;  
    disp(['Effective Bitrate: ', num2str(bitrate / 1000), ' kbit/s']);
end
