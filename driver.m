congruentfigures = [];
incongruentfigures = [];
numberofstimuli = input('Enter the number of figures shown in the experiment: ');
coupleorrange =input('Enter 1 to generate a selection of figures or enter 2 to generate a range of figures: ');
if coupleorrange == 1
    NumberOfFiguresToGenerate = input('How many figures do you want to create? ');
    for i = 1:NumberOfFiguresToGenerate
        figurenumber = input(['Enter figure' ' ' int2str(i) ': ']);
        if figurenumber <= numberofstimuli/2
            congruentfigures(end+1) = figurenumber;
        else
            incongruentfigures(end+1) = figurenumber;
        end
    end
else
    StartingFigure = input('Enter the starting figure: ');
    EndingFigure = input('Enter the ending figure: ');
    for i = StartingFigure:EndingFigure
        if i <= numberofstimuli/2
            congruentfigures(end+1) = i;
        else
            incongruentfigures(end+1) = i;
        end
    end
end

initials = input('Enter the test subject''s initials: ','s');

file = input('name of session list-->', 's');
fid = fopen([file '.asc']);
datc = input('Enter the name of the congruent .dat file: ','s');
datc = [datc '.dat'];
dati = input('Enter the name of the incongruent .dat file: ','s');
dati = [dati '.dat'];

line_count = 1;
while feof(fid) == 0
    line_data{line_count} = fgetl(fid);
    line_count = line_count +1 ;
end
line_count = line_count-1;

for a = congruentfigures
    start_index = 1;
    end_index = 1;
    
    for index = 1:line_count
        str = strfind(line_data(index), strcat('C-Test',num2str(a)));
        if ~isempty(str{1})
            start_index = index;
            break;
        end
    end
    
    for index = 1:line_count
        str = strfind(line_data(index), strcat('EC-Test',num2str(a)));
        if ~isempty(str{1})
            end_index = index;
            break;
        end
    end
    b = a;
    Stroop_Analysis2
end

for a = incongruentfigures
    a = a-150;
    start_index = 1;
    end_index = 1;
    
    for index = 1:line_count
        str = strfind(line_data(index), strcat('I-Test',num2str(a)));
        if ~isempty(str{1})
            start_index = index;
            break;
        end
    end
    
    for index = 1:line_count
        str = strfind(line_data(index), strcat('EI-Test',num2str(a)));
        if ~isempty(str{1})
            end_index = index;
            break;
        end
    end
    
    b=a+numberofstimuli/2;
    Stroop_Analysis2
end

for i = congruentfigures
    saveas(figure(i),strcat('Figure',num2str(i),initials),'jpg')
end
for i = incongruentfigures
    saveas(figure(i),strcat('Figure',num2str(i),initials),'jpg')
end

