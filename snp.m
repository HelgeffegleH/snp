% Salt and pepper noise removal.
function O = snp(Y)

% Decide level of noise and set the initial window size s.
[H, W] = size(Y);
n = (nnz(Y == 255) + nnz(Y == 0)) / (H * W);
if n < 0.55
    s = 3;
elseif n >= 0.55 && n < 0.9
    s = 5;
else
    s = 7;
end
% Make Y double
Y = double(Y);
O = zeros(H, W);
Y = padarray(Y, [12 12], -1);
for h = 13:H+12
    % Progress tracker.
    if rem(h,100) == 0
        clc
        format shortg
        time = clock;
        fix(time);
        disp([num2str(h/H*100) ' % done @ ' num2str(time(4)) ':' num2str(time(5)) ':' num2str(time(6))])
    end
    for w = 13:W+12
        S = Y(h-1:h+1, w-1:w+1);
        s = length(S);
        u = reshape(S', s*s, 1);
        Z = [];
        for i=1:length(u)
            if u(i) ~= 0 && u(i) ~= 255 && u(i) ~= -1
                Z = [Z; u(i)];
            end
        end
        L = size(Z);
        counter = 0;
        while L < 4
            if L == 3
                Z = [Z; Z(3)];
                O(H, W) = pt(Z);
                break
            elseif L == 2
                S = Y(h-2-counter:h+2+counter, w-2-counter:w+2+counter);
                s = length(S);
                u = reshape(S', s*s, 1);
                for i=1:length(u)
                    if u(i) ~= 0 && u(i) ~= 255 && u(i) ~= -1
                        Z = [Z; u(i)];
                    end
                end
            elseif L == 1
                S = Y(h-4-counter:h+4+counter, w-4-counter:w+4+counter);
                s = length(S);
                u = reshape(S', s*s, 1);
                for i=1:length(u)
                    if u(i) ~= 0 && u(i) ~= 255 && u(i) ~= -1
                        Z = [Z; u(i)];
                    end
                end
            elseif L == 0;
                S = Y(h-6-counter:h+6+counter, w-6-counter:w+6+counter);
                s = length(S);
                u = reshape(S', s*s, 1);
                for i=1:length(u)
                    if u(i) ~= 0 && u(i) ~= 255 && u(i) ~= -1
                        Z = [Z; u(i)];
                    end
                end
            end
            L = length(Z);
            counter = counter + 1;
        end
        O(h,w) = pt(Z);
    end
end
O = O(13:H+12, 13:W+12);
S(S == 0) = 255;
O(S ~= 255) = S(S~=255);
O = uint8(O);
end

