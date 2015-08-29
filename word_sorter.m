% function error_code = word_sorter()
clear all;
clc;
fclose('all');
swords_path = fopen('stop_words');
swords_file = fread(swords_path,'*char')';
swords = swords_file;
swords = strsplit(swords);
fclose('all');
current_file_int = 1;
fin_text = ' ';
spacer = '.';

file_namer = int2str(current_file_int);
file_namer = strcat(file_namer,'.txt');
file_id = fopen(file_namer);

%file_id = fopen('k2.txt');


while (file_id > -1)
    
    text = fread(file_id,'*char')';
    text = strcat(text,spacer);
    fin_text = strcat(fin_text,text);
    fclose(file_id);
    current_file_int  = current_file_int + 1;
    
    file_namer = int2str(current_file_int);
    file_namer = strcat(file_namer,'.txt');
    file_id = fopen(file_namer);
    
end
fin_text = lower(fin_text);
% words = strsplit(fin_text);

%% Removing punctuation marks
counter_a = 1;
end_of_text = length(fin_text);


while (counter_a <= end_of_text)
    if (fin_text(counter_a) == '.' || fin_text(counter_a) == ',' || fin_text(counter_a) == '!' || fin_text(counter_a) == '?' || fin_text(counter_a) == ':' || fin_text(counter_a) == ';' || fin_text(counter_a) == '"' || fin_text(counter_a) == '(' || fin_text(counter_a) == ')')
        
        fin_text(counter_a) = ' ';
        
    end
    counter_a = counter_a + 1;
end
words = strsplit(fin_text);
end_of_words = length(words);

%% Remove one to remove null value
end_of_words = end_of_words - 1;

%% Removing STOP Words

for st = 1:end_of_words

    
    for sw = 1:length(swords)
    
    if (strcmp(swords{sw},words{st}))
 %       fprintf('Y for i = %d and j = %d\n',st,sw);    
        words{st} = [];
        break
    end
    
    end
end



%% First Iteration

sarray{1} = words{1};
freq_c(1) = 0;

if (end_of_words > 1)
    
    %     for i = 1:fin_c
    %
    %         for j = 1:fin_c
    %
    %             if (words{i} == words{j})
    %
    %             end
    %
    %         end
    %
    %     end
    word_found = 0;
    for i = 1:end_of_words
        %     disp('e');
        
        for j = 1:length(sarray)
            
            
            word_found = 0;
            if (strmatch(words{i}, sarray{j}) == 1)
                %                fprintf('Y for i = %d and j = %d\n',i,j);
                freq_c(j) = freq_c(j) + 1;
                word_found = 1;
                break
            end
        end
        
        if (word_found == 0)
            %           fprintf('N for i = %d and j = %d\n',i,j);
            sarray{(length(sarray) + 1)} = words{i};
            freq_c((length(freq_c) + 1)) = 1;
            
        end
        
        
        
    end
    %    disp('c');
    
end
%disp('d');

%sarray
%freq_c


%% Sorting
end_of_sorted_array = length(sarray);

for b = 1:end_of_sorted_array
    
    
    for t = 1:(end_of_sorted_array-1)
        
        if (freq_c(t) < freq_c(t + 1))
            
            % SWAP using temporary variable
            
            temp_1 = freq_c(t);
            freq_c(t) = freq_c(t + 1);
            freq_c(t + 1) = temp_1;
            
            temp_2 = sarray(t);
            sarray(t) = sarray(t + 1);
            sarray(t + 1) = temp_2;
            
        end
        
    end
    
end

error_code = 0;
%% The shifter

for y = 1:(length(sarray)-1)
    
   sarray{y} = sarray{y+1}; 
    
end


%% File writing

fclose('all');


fileID = fopen('D:\Research VIDEO\OUTPUT\exp2.txt','w');
%sarray = string(sarray);
for h = 1:length(sarray)
    
    fprintf(fileID,sarray{h});
    fprintf(fileID,',');
end
fclose(fileID);

fprintf('Word Sort Complete. Error code: %d\n',error_code);

%end




