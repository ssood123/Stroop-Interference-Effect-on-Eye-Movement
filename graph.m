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
