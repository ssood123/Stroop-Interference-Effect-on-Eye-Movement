verystart = input('Enter start time');
index = 1;
timeslist = [];
boundarystart = zeros(1,12);
boundaryend = zeros(1,12);
currenttime = verystart;
fid = fopen('kuangrichard03-Jul-2018.dat');
while feof(fid) == 0
    currenttime = currenttime + 1000;
    getdata = fgetl(fid);
    getdata = strsplit(getdata);
    gettime = str2double(getdata{3});
    boundarystart(index) = currenttime;
    currenttime = currenttime + gettime * 1000;
    boundaryend(index) = currenttime;
    index = index+1;
end
fclose(fid);
file = input('Enter the name of the .asc file: ','s');
lefteyex = [];
lefteyey = [];
righteyex = [];
righteyey = [];
for i = 1:12
    fid = fopen(strcat(file,'.asc'));
    lefteyex = [];
    lefteyey = [];
    righteyex = [];
    righteyey = [];
    while feof(fid) == 0
        line = fgetl(fid);
        line = strsplit(line);
        if str2double(line{1}) >= boundarystart(i) && str2double(line{1}) <= boundaryend(i)
            lefteyex(end+1) = str2double(line{2});
            lefteyey(end+1) = str2double(line{3});
            righteyex(end+1) = str2double(line{5});
            righteyey(end+1) = str2double(line{6});
        end
    end
    figure(i)
    plot(lefteyex,lefteyey,'ko');
    xlim([0 1000])
    ylim([0 1000])
    fclose(fid);
end
