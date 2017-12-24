function SizeInPixels = SizeInPixels(img)
    img=img(:,:,1);
    bw = imbinarize(img);
    SizeInPixels = sum(bw(:)==0);
end