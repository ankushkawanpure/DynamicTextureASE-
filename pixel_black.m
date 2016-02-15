
ab=imread('bear_15_1.png');
x=46;
y=220;
while x<80
    y=220;
    while y<240
    ab(x,y,:)=[0,0,0];
    y=y+1;
    end
    x=x+1;
end

imshow(ab)
imwrite(ab,'bear_15_2.png')