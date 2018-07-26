congruentstack = numberofstimuli/2:-1:1;
incongruentstack = numberofstimuli:-1:numberofstimuli/2+1;
correctorder = [];
counter = 1;
nameofchronologicalfile = input('Enter the name of the chronological .dat file: ','s');
nameofchronologicalfile = strcat(nameofchronologicalfile,'.dat');
fid = fopen(nameofchronologicalfile);
while feof(fid) == 0
    line = fgetl(fid);
    line = strsplit(line);
    wordandcolor = [line{1} line{2}];
    if length(congruentstack) >= 1
    figure(congruentstack(end))
    h1=gca; 
    title1= h1.Title.String;
    end
    if length(incongruentstack) >= 1
    figure(incongruentstack(end))
    h2 = gca;
    title2 = h2.Title.String;
    end
    if strcmp(title1,wordandcolor)
        correctorder(end+1) = congruentstack(end);
        congruentstack(end) = [];
    elseif strcmp(title2,wordandcolor)
        correctorder(end+1) = incongruentstack(end);
        incongruentstack(end) = [];
    end
end
