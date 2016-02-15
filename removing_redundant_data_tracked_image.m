for i=bbox(2):bbox(2)+bbox(4)
    for j=bbox(1):bbox(1)+bbox(3)
        if(fore(i,j)<20)
            temp(i,j,:)=[255];
        end
                

    end
end

imwrite(temp,'afterRedundantRemoval.jpg');

