%% C) Π shaped obstacle
clc;
clear;
close all;

%initial_pos = [randi([1,20],5,1) randi([1,20],5,1)]; %Initial robot positions
initial_pos = [15 10;15 11;15 12;15 9;15 8;];%Set initial positions to get stuck in the obstacle

for i = 1:5
    j = i + 5;
    workspace = zeros(20);%Initialize workspace
    workspace(3,9) = 1;%Set target position
    %Set the pi shaped obstacle
    workspace(7,5:15)=3;
    workspace(8:12,5)=3;
    workspace(8:12,15)=3;
    %Initialize robot
    robot = true;
    while robot
        if (initial_pos(i) == 3) && (initial_pos(j) == 9)%Check if the robot was placed on the charger
            disp("The robot was initialized at the targer position!");
        elseif workspace(initial_pos(i),initial_pos(j)) == 3%Check if the robot was placed on an obstacle
            disp("The robot can't be initialized on an obstacle!");
            initial_pos(i) = randi([1,20]);
            initial_pos(j) = randi([1,20]);
        else
            workspace(initial_pos(i),initial_pos(j)) = 2;%Otherwise place the robot
            robot = false;
            disp(workspace);
        end
    end
    %Apply the algorithm to go to the charger
    figure;
    row_cnt = 0;
    while (initial_pos(i)~=3)||(initial_pos(j)~=9)
        while initial_pos(i)>3%Go UP
            if (workspace(initial_pos(i)-1,initial_pos(j)) ~= 3)%If there isn't an obstacle forward
                workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                initial_pos(i)=initial_pos(i)-1;%The forward position
                workspace(initial_pos(i),initial_pos(j)) = 2;%Goes UP
                disp(workspace);
                %heatmap(workspace);
            else%Dodge the obstacle in front of you
                starting_row = workspace(initial_pos(i));
                if (initial_pos(j)>1)&&(workspace(initial_pos(i),initial_pos(j)-1) ~= 3)%No obstacle to the left
                    while (workspace(initial_pos(i)-1,initial_pos(j)) == 3)&&(initial_pos(j)>1)&&(workspace(initial_pos(i),initial_pos(j)-1) ~= 3)%Obstacle in front of you
                        workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                        initial_pos(j)=initial_pos(j)-1;%The left position
                        workspace(initial_pos(i),initial_pos(j)) = 2;%Goes LEFT
                        disp(workspace);
                        %heatmap(workspace);
                    end
                elseif (initial_pos(j)<20)&&(workspace(initial_pos(i),initial_pos(j)+1) ~= 3)%No obstacle to the right
                    while (workspace(initial_pos(i)-1,initial_pos(j)) == 3)&&(initial_pos(j)<20)&&(workspace(initial_pos(i),initial_pos(j)+1) ~= 3)
                        workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                        initial_pos(j)=initial_pos(j)+1;%The right position
                        workspace(initial_pos(i),initial_pos(j)) = 2;%Goes RIGHT
                        disp(workspace);
                        %heatmap(workspace);
                    end
                end
                current_row = workspace(initial_pos(i));
                if starting_row == current_row%Check the row
                    row_cnt = row_cnt + 1;
                    if row_cnt >=6%Check if stuck
                        disp("The robot is stuck at the same row");
                        %Algorithm to get unstuck
                        if (workspace(initial_pos(i)+1,initial_pos(j))~=3)&&(workspace(initial_pos(i),initial_pos(j)-1)==3)%Stuck with obstacles at left
                            while (workspace(initial_pos(i),initial_pos(j)-1)==3)%Go back until there is no obstacle to the left
                                workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                                initial_pos(i) = initial_pos(i)+1;
                                workspace(initial_pos(i),initial_pos(j)) = 2;%The robot goes BACK
                            end
                            workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                            initial_pos(j)=initial_pos(j)-1;%The left position
                            workspace(initial_pos(i),initial_pos(j)) = 2;%Goes LEFT
                            while workspace(initial_pos(i)-1,initial_pos(j))==3%Keep going left until there is no obstacle in front
                                workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                                initial_pos(j)=initial_pos(j)-1;%The left position
                                workspace(initial_pos(i),initial_pos(j)) = 2;%Goes LEFT
                            end
                        elseif (workspace(initial_pos(i)+1,initial_pos(j))~=3)&&(workspace(initial_pos(i),initial_pos(j)+1)==3)%Stuck with obstacles at right
                            while (workspace(initial_pos(i),initial_pos(j)+1)==3)%Go back until there is no obstacle to the right 
                                workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                                initial_pos(i) = initial_pos(i)+1;
                                workspace(initial_pos(i),initial_pos(j)) = 2;%The robot goes BACK
                            end
                            workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                            initial_pos(j)=initial_pos(j)+1;%The right position
                            workspace(initial_pos(i),initial_pos(j)) = 2;%Goes RIGHT
                            while workspace(initial_pos(i)-1,initial_pos(j))==3%Keep going right until there is no obstacle in front
                                workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                                initial_pos(j)=initial_pos(j)+1;%The right position
                                workspace(initial_pos(i),initial_pos(j)) = 2;%Goes RIGHT
                            end
                        end
                    end
                end
            end
        end
        while initial_pos(i)<3%Go DOWN
            if workspace(initial_pos(i)+1,initial_pos(j)) ~= 3%If there isn't an obstacle behind
                workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                initial_pos(i)=initial_pos(i)+1;%The position behind
                workspace(initial_pos(i),initial_pos(j)) = 2;%Goes BACK
                disp(workspace);
                %heatmap(workspace);
            else%Dodge the obstacle
                if (initial_pos(j)>1)&&(workspace(initial_pos(i),initial_pos(j)-1) ~= 3)%No obstacle to the left
                    while (workspace(initial_pos(i)+1,initial_pos(j)) == 3)&&(initial_pos(j)>1)&&(workspace(initial_pos(i),initial_pos(j)-1) ~= 3)
                        workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                        initial_pos(j)=initial_pos(j)-1;%The left position
                        workspace(initial_pos(i),initial_pos(j)) = 2;%Goes LEFT
                        disp(workspace);
                        %heatmap(workspace);
                    end
                elseif (initial_pos(j)<20)&&(workspace(initial_pos(i),initial_pos(j)+1) ~= 3)%No obstacle to the right
                    while (workspace(initial_pos(i)+1,initial_pos(j)) == 3)&&(initial_pos(j)<20)&&(workspace(initial_pos(i),initial_pos(j)+1) ~= 3)
                        workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                        initial_pos(j)=initial_pos(j)+1;%The right position
                        workspace(initial_pos(i),initial_pos(j)) = 2;%Goes RIGHT
                        disp(workspace);
                        %heatmap(workspace);
                    end
                end
            end
        end
        while initial_pos(j)>9%Go LEFT
            if workspace(initial_pos(i),initial_pos(j)-1) ~= 3%If there isn't an obstacle to the left
                workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                initial_pos(j)=initial_pos(j)-1;%The left position
                workspace(initial_pos(i),initial_pos(j)) = 2;%Goes LEFT
                disp(workspace);
                %heatmap(workspace);
            else%Dodge the obstacle
                if (initial_pos(i)<20)&&(workspace(initial_pos(i)+1,initial_pos(j)) ~= 3)%No obstacle behind
                    while(workspace(initial_pos(i),initial_pos(j)-1) == 3)&&(initial_pos(i)<20)&&(workspace(initial_pos(i)+1,initial_pos(j)) ~= 3)
                        workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                        initial_pos(i)=initial_pos(i)+1;%The position behind
                        workspace(initial_pos(i),initial_pos(j)) = 2;%Goes BACK
                        disp(workspace);
                        %heatmap(workspace);
                    end
                elseif (initial_pos(i)>1)&&(workspace(initial_pos(i)-1,initial_pos(j)) ~= 3)%No ostacle forward
                    while(workspace(initial_pos(i),initial_pos(j)-1) == 3)&&(initial_pos(i)>1)&&(workspace(initial_pos(i)-1,initial_pos(j)) ~= 3)
                        workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                        initial_pos(i)=initial_pos(i)-1;%The forward position
                        workspace(initial_pos(i),initial_pos(j)) = 2;%Goes UP
                        disp(workspace);
                        %heatmap(workspace);
                    end
                end
            end
        end
        while initial_pos(j)<9%Go RIGHT
            if workspace(initial_pos(i),initial_pos(j)+1) ~= 3%If there isn't and obstacle to the right
                workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                initial_pos(j)=initial_pos(j)+1;%The right position
                workspace(initial_pos(i),initial_pos(j)) = 2;%Goes RIGHT
                disp(workspace);
                %heatmap(workspace);
            else%Dodge the obstacle
                if (initial_pos(i)<20)&&(workspace(initial_pos(i)+1,initial_pos(j)) ~= 3)%No obstacle behind
                    while (workspace(initial_pos(i),initial_pos(j)+1) == 3)&&(initial_pos(i)<20)&&(workspace(initial_pos(i)+1,initial_pos(j)) ~= 3)
                        workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                        initial_pos(i)=initial_pos(i)+1;%The position behind
                        workspace(initial_pos(i),initial_pos(j)) = 2;%Goes BACK
                        disp(workspace);
                        %heatmap(workspace);
                    end
                elseif (initial_pos(i)>1)&&(workspace(initial_pos(i)-1,initial_pos(j)) ~= 3)%No obstacle forward
                    while (workspace(initial_pos(i),initial_pos(j)+1) == 3)&&(initial_pos(i)>1)&&(workspace(initial_pos(i)-1,initial_pos(j)) ~= 3)
                        workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                        initial_pos(i)=initial_pos(i)-1;%The forward position
                        workspace(initial_pos(i),initial_pos(j)) = 2;%Goes UP
                        disp(workspace);
                        %heatmap(workspace);
                    end
                end
            end
        end
    end
    heatmap(workspace);
    disp("The robot reached the charger!");
end
