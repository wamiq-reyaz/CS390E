%% randProjection.m
%% Author: Wamiq Reyaz, VCC, KAUST

function mat = randProjection()
   while(1)
        cood = num2cell(rand(1, 6));
        [right, left, near, far, top, bottom] = cood{:};
        % rejection sampling
        if(right ~= left && near ~= far && top ~= bottom)
             break;
        end
   end
   
      mat = [2/(right -left), 0, 0, -(right+left)/(right-left);
           0, 2/(top+bottom), 0 , -(top+bottom)/(top-bottom);
           0, 0, 2/(near+far), -(near+far)/(near-far);
           0, 0,0, 1];
end