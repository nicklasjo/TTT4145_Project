function decoded = dequantize_upsample(encoded, num_bits, fs)
    % Convert back to double in range [-1, 1]
    max_val = 2^(num_bits - 1) - 1;
    decoded = double(encoded) / max_val;
    
    % Play the decoded audio
    disp('Playing reconstructed audio...');
    sound(decoded, fs);

    % Save as audio file
    audiowrite('quantized_audio.wav', decoded, fs);
end
