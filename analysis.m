verystart = input('Enter start time: ');
index = 1;
timeslist = [];
boundarystart = zeros(1,12);
boundaryend = zeros(1,12);
words = cell(1,12);
colors = cell(1,12);
colorlabel = [0 0 0];
currenttime = verystart;
fid = fopen('kuangrichard03-Jul-2018.dat');
while feof(fid) == 0
    currenttime = currenttime + 1000;
    getdata = fgetl(fid);
    getdata = strsplit(getdata);
    gettime = str2double(getdata{3});
    words{index} = getdata{1};
    colors{index} = getdata{2};
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
    hFig = figure(i);
    set(hFig, 'Position', [0 0 1280 720])
    plot(righteyex,righteyey,'co');
    hold on
    plot(lefteyex,lefteyey,'ko');
    if strcmp(colors{i},'Orange') == 1
        colorslabel = [1 .5 0];
    elseif strcmp(colors{i},'Purple') == 1
        colorslabel = 'magenta';
    else
        colorslabel = lower(colors{i});
    end
    text(640,360,words{i},'fontsize',200,'HorizontalAlignment','center','color',colorslabel);
    xlim([0 1280])
    ylim([0 720])
    fclose(fid);
end
