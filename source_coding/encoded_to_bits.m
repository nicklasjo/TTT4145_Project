function encoded_bits = encoded_to_bits(encoded)
    % Determine the bit depth (e.g., 8 bits per sample)
    bit_depth = 8;  % 8 bits for each sample (adjust as needed)
    
    % Initialize an empty matrix to store the encoded bits as 2D binary array
    encoded_bits = zeros(length(encoded), bit_depth);
    
    % Loop through each encoded sample
    for i = 1:length(encoded)
        % Convert each sample to a binary string (with leading zeros to ensure 8 bits)
        binary_sample = dec2bin(encoded(i), bit_depth);
        
        % Convert binary string to a 1x8 vector of bits and assign it to the corresponding row
        encoded_bits(i, :) = arrayfun(@(x) str2double(x), binary_sample);
    end
    
    % Display the 2D matrix of encoded bits
    disp('Encoded Bits (2D list):');
    disp(encoded_bits);
end
