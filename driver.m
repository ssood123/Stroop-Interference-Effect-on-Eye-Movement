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

for a = 1:numberofstimuli/2
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
    analysis
end

for a = 1:numberofstimuli/2
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
    analysis
end


