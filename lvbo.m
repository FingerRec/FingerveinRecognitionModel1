function shuchu = lvbo(shuru, d)
%preprocess�е��ã��Զ�ֵͼ������˲�
for j = 1:3
    [g, num] = bwlabel(shuru, 4);
    for i = 1:num
        [r,c] = find(bwlabel(shuru, 4) == i);
        area = bwarea(find(bwlabel(shuru, 4) == i));
        if area < d
            shuru(r, c) = 0;
        end
    end
end
shuchu = shuru;