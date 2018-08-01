startingfigure = input('What is the starting figure? ');
endingfigure = input('What is the ending figure? ');
nameextension = input('Enter the name extension: ','s');
for i = startingfigure:endingfigure
    saveas(figure(i),strcat('Figure',num2str(i),nameextension),'jpg')
end
