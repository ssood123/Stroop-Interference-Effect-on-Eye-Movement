left_data = [];
right_data = [];
special_types = [];
trial_breaks = [];

current_type = 0;
startSacLeft = [];
startSacRight = [];
endSacLeft = [];
endSacRight = [];
startFixLeft = [];
startFixRight = [];
endFixLeft = [];
endFixRight = [];
endsPosL = [];
SaccPosL = [];
FixPosL = [];
BlinkPosL = [];
endsPosR = [];
SaccPosR = [];
FixPosR = [];
BlinkPosR = [];
SDIS = [];
EDIS = [];

firstln = strsplit(char(line_data(start_index)));
startT = firstln(1, 2);
for index = start_index + 1:end_index
    data = strsplit(char(line_data(index)));
    
    if(strcmp(data(1, 1), 'SFIX'))
        current_type = 1;
        % n = 'START FIXATION'
    elseif(strcmp(data(1, 1), 'EFIX'))
        current_type = 0;
        if (strcmp(data(1, 2), 'L'))
            startFixLeft = [startFixLeft; data(1, 3)];
            endFixLeft = [endFixLeft; data(1, 4)];
        elseif (strcmp(data(1, 2), 'R'))
            startFixRight = [startFixRight; data(1, 3)];
            endFixRight = [endFixRight; data(1, 4)];
        end
    elseif(strcmp(data(1, 1), 'SSACC'))
        current_type = 2;
    elseif(strcmp(data(1, 1), 'ESACC'))
        current_type = 0;
        if (strcmp(data(1, 2), 'L'))
            startSacLeft = [startSacLeft; data(1, 3)];
            endSacLeft = [endSacLeft; data(1, 4)];
        elseif (strcmp(data(1, 2), 'R'))
            startSacRight = [startSacRight; data(1, 3)];
            endSacRight = [endSacRight; data(1, 4)];
        end
    elseif(strcmp(data(1, 1), 'SBLINK'))
        current_type = -1;
    elseif(strcmp(data(1, 1), 'EBLINK'))
        current_type = 0;
    elseif(strcmp(data(1, 3), 'SDIS'))
        SDIS = [SDIS data(1, 2)];
    elseif(strcmp(data(1, 3), 'EDIS'))
        EDIS = [EDIS data(1, 2)];
    end
    
    %         str = strfind(line_data(index), 'NEWTRIAL');
    %         if ~isempty(str{1})
    %             size_left = size(left_data);
    %             rows = size_left(1);
    %             trial_breaks = [trial_breaks; rows];
    %         end
    
    
    if(length(data) == 8)
        left_data = [left_data; data(1,2) data(1,3)];
        right_data = [right_data; data(1,5) data(1,6)];
        special_types = [special_types; current_type];
        switch current_type
            case 0
                endsPosL = [endsPosL; data(1,2) data(1, 3)];
                endsPosR = [endsPosR; data(1,5) data(1, 6)];
            case 1
                FixPosL = [FixPosL; data(1,2) data(1, 3)];
                FixPosR = [FixPosR; data(1,5) data(1, 6)];
            case 2
                SaccPosL = [SaccPosL; data(1,2) data(1, 3)];
                SaccPosR = [SaccPosR; data(1,5) data(1, 6)];
            case -1
                BlinkPosL = [BlinkPosL; data(1,2) data(1, 3)];
                BlinkPosR = [BlinkPosR; data(1,5) data(1, 6)];
        end
    end
end

endSacLeft = str2double(endSacLeft)- str2double(startT);
startSacLeft = str2double(startSacLeft)- str2double(startT);
durSacLeft = endSacLeft - startSacLeft;

endSacRight = str2double(endSacRight)- str2double(startT);
startSacRight = str2double(startSacRight)- str2double(startT);
durSacRight = endSacRight - startSacRight;

numSacLeft = size(durSacLeft,1);
numSacRight = size(durSacRight,1);

endFixLeft = str2double(endFixLeft)- str2double(startT);
startFixLeft = str2double(startFixLeft)- str2double(startT);
durFixLeft = endFixLeft - startFixLeft;

endFixRight = str2double(endFixRight)- str2double(startT);
startFixRight = str2double(startFixRight)- str2double(startT);
durFixRight = endFixRight - startFixRight;

numFixLeft = size(durFixLeft,1);
numFixRight = size(durFixRight,1);

SDIS = str2double(SDIS)- str2double(startT);
EDIS = str2double(EDIS) - str2double(startT);
durDIS = EDIS - SDIS;
numDIS = size(durDIS, 1);

alldata = [left_data right_data num2cell(special_types)];

hold off
hold on
axis([0 1280 0 720])
figure(1)
if ~isempty(BlinkPosL)
    plot(str2double(BlinkPosL(:, 1)), str2double(BlinkPosL(:, 2)), 'ko')
end
hold on
if ~isempty(endsPosL)
    plot(str2double(endsPosL(:, 1)), str2double(endsPosL(:, 2)), 'bo')
end
hold on
if ~isempty(FixPosL)
    plot(str2double(FixPosL(:, 1)), str2double(FixPosL(:, 2)), 'go')
end
hold on
if ~isempty(SaccPosL)
    plot(str2double(SaccPosL(:, 1)), str2double(SaccPosL(:, 2)), 'ro')
end

hold off
figure(a+6)
hold on
axis([0 1280 0 720])
if ~isempty(BlinkPosR)
    plot(str2double(BlinkPosR(:, 1)), str2double(BlinkPosR(:, 2)), 'ko')
end
hold on
if ~isempty(endsPosR)
    plot(str2double(endsPosR(:, 1)), str2double(endsPosR(:, 2)), 'bo')
end
hold on
if ~isempty(FixPosR)
    plot(str2double(FixPosR(:, 1)), str2double(FixPosR(:, 2)), 'go')
end
hold on

if ~isempty(SaccPosR)
    plot(str2double(SaccPosR(:, 1)), str2double(SaccPosR(:, 2)), 'ro')
end
