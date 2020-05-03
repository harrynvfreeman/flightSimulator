function plot4(in)
x = in(1,:);
y = in(2,:);
z = in(3,:);
c0 = 1:length(x);
figure
cmap = colormap;
% change c into an index into the colormap
% min(c) -> 1, max(c) -> number of colors
c = round(1+(size(cmap,1)-1)*(c0 - min(c0))/(max(c0)-min(c0)));
% make a blank plot
plot3(x,y,z,'linestyle','none')
% add line segments
for k = 1:(length(x)-1)
    line(x(k:k+1),y(k:k+1),z(k:k+1),'color',cmap(c(k),:))
end
colorbar
caxis([ min(c0) , max(c0)]) % colorbar limits 

end