numberofstimuli = 300;
congruentstack = numberofstimuli/2:-1:1;
incongruentstack = numberofstimuli:-1:numberofstimuli/2+1;
correctorder = [];
counter = 1;
nameofchronologicalfile = input('Enter the name of the chronological .dat file: ','s');
nameofcongruentfile = strcat(nameofchronologicalfile,'c.dat');
nameofincongruentfile = strcat(nameofchronologicalfile,'i.dat');
nameofchronologicalfile = strcat(nameofchronologicalfile,'.dat');
fid = fopen(nameofchronologicalfile);
while feof(fid) == 0
    fidc = fopen(nameofcongruentfile);
    fidi = fopen(nameofincongruentfile);
    line = fgetl(fid);
    line = strsplit(line);
    wordandcolor = [line{1} line{2}];
    if length(congruentstack) >= 1
        for i = 1:congruentstack(end)
            title1 = fgetl(fidc);
        end
        title1 = strsplit(title1);
        title1 = [title1{1} title1{2}];
    end
    if length(incongruentstack) >= 1
         for i = 1:incongruentstack(end)-numberofstimuli/2
            title2 = fgetl(fidi);
         end
        title2 = strsplit(title2);
        title2 = [title2{1} title2{2}];
    end
    if strcmp(title1,wordandcolor)
        correctorder(end+1) = congruentstack(end);
        congruentstack(end) = [];
    elseif strcmp(title2,wordandcolor)
        correctorder(end+1) = incongruentstack(end);
        incongruentstack(end) = [];
    end
    fclose(fidc);
    fclose(fidi);
end
fclose(fid);
