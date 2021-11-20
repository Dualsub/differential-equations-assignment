function [res] = norm2(w, y)
    res = sqrt((1/length(w)) * sum((w - y).^2));
end

