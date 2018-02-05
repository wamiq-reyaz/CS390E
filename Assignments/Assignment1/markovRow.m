function prob = markovRow(len)
    prob = zeros(1,len);

    remaining = 1;
    for i= 1:len-1
        prob(i) = rand * remaining;
        remaining = max(0, remaining - prob(i));
    end

    prob(len) = remaining;
end
