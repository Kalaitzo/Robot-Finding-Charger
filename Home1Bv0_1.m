%% B) 50 Obstacles in th workspace
clc;
clear;
close all;

initial_pos = [randi([1,20],5,1) randi([1,20],5,1)]; %Initial robot positions

for i = 1:5
    j = i + 5;
    workspace = zeros(20);%Initialize workspace
    workspace(3,9) = 1;%Set target position
    obs = 50;%Amount of obstacles
    while obs>0%Set obstcles in the workspace
        obs_pos = [randi([1,20]) randi([1,20])];%Set obstacle position
        if (obs_pos(1) == 3) && (obs_pos(2) == 9)%Check if the obstacle is placed on the charger
            disp("Can't place obstacles on the charger");
        elseif workspace(obs_pos(1),obs_pos(2))==0%Otherwise place the obstacle
            workspace(obs_pos(1,1), obs_pos(1,2)) = 3;
            obs = obs - 1;
        end
    end
    %Initialize robot
    if (initial_pos(i) == 3) && (initial_pos(j) == 9)%Check if the robot was placed on the charger
        disp("The robot was initialized at the targer position!");
    elseif workspace(initial_pos(i),initial_pos(j)) == 3%Check if the robot was placed on an obstacle
        disp("The robot can't be initialized on an obstacle!");
    else
        workspace(initial_pos(i),initial_pos(j)) = 2;%Otherwise place the robot
        disp(workspace);
    end
    figure;
    %Apply the algorithm to go to the charger
    while (initial_pos(i)~=3)||(initial_pos(j)~=9)
        while initial_pos(i)>3%Go UP
            if (workspace(initial_pos(i)-1,initial_pos(j)) ~= 3)%If there isn't an obstacle forward
                workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                initial_pos(i)=initial_pos(i)-1;%The forward position
                workspace(initial_pos(i),initial_pos(j)) = 2;%Goes UP
                disp(workspace);
                heatmap(workspace);
            else%Dodge the obstacle in front of you
                if (initial_pos(j)>1)&&(workspace(initial_pos(i),initial_pos(j)-1) ~= 3)%No obstacle to the left
                    while (workspace(initial_pos(i)-1,initial_pos(j)) == 3)&&(initial_pos(j)>1)&&(workspace(initial_pos(i),initial_pos(j)-1) ~= 3)%Obstacle in front of you
                        workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                        initial_pos(j)=initial_pos(j)-1;%The left position
                        workspace(initial_pos(i),initial_pos(j)) = 2;%Goes LEFT
                        disp(workspace);
                        heatmap(workspace);
                    end
                elseif (initial_pos(j)<20)&&(workspace(initial_pos(i),initial_pos(j)+1) ~= 3)%No obstacle to the right
                    while (workspace(initial_pos(i)-1,initial_pos(j)) == 3)&&(initial_pos(j)<20)&&(workspace(initial_pos(i),initial_pos(j)+1) ~= 3)
                        workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                        initial_pos(j)=initial_pos(j)+1;%The right position
                        workspace(initial_pos(i),initial_pos(j)) = 2;%Goes RIGHT
                        disp(workspace);
                        heatmap(workspace);
                    end
                elseif (initial_pos(i)<20)&&(workspace(initial_pos(i)+1,initial_pos(j)) ~= 3)%No obstacle only behind the robot
                    workspace(initial_pos(i),initial_pos(j)) = 0.5;
                    while(workspace(initial_pos(i),initial_pos(j)-1) == 3)%Obstacle to the left
                        workspace(initial_pos(i),initial_pos(j)) = 0.5;
                        initial_pos(i) = initial_pos(i)+1;
                        workspace(initial_pos(i),initial_pos(j)) = 2;%Goes BACK
                    end
                    workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                    initial_pos(j)=initial_pos(j)-1;%The left position
                    workspace(initial_pos(i),initial_pos(j)) = 2;%Goes LEFT
                    disp(workspace);
                    heatmap(workspace);
                end
            end
        end
        while initial_pos(i)<3%Go DOWN
            if workspace(initial_pos(i)+1,initial_pos(j)) ~= 3%If there isn't an obstacle behind
                workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                initial_pos(i)=initial_pos(i)+1;%The position behind
                workspace(initial_pos(i),initial_pos(j)) = 2;%Goes BACK
                disp(workspace);
                heatmap(workspace);
            else%Dodge the obstacle
                if (initial_pos(j)>1)&&(workspace(initial_pos(i),initial_pos(j)-1) ~= 3)%No obstacle to the left
                    while (workspace(initial_pos(i)+1,initial_pos(j)) == 3)&&(initial_pos(j)>1)&&(workspace(initial_pos(i),initial_pos(j)-1) ~= 3)
                        workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                        initial_pos(j)=initial_pos(j)-1;%The left position
                        workspace(initial_pos(i),initial_pos(j)) = 2;%Goes LEFT
                        disp(workspace);
                        heatmap(workspace);
                    end
                elseif (initial_pos(j)<20)&&(workspace(initial_pos(i),initial_pos(j)+1) ~= 3)%No obstacle to the right
                    while (workspace(initial_pos(i)+1,initial_pos(j)) == 3)&&(initial_pos(j)<20)&&(workspace(initial_pos(i),initial_pos(j)+1) ~= 3)
                        workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                        initial_pos(j)=initial_pos(j)+1;%The right position
                        workspace(initial_pos(i),initial_pos(j)) = 2;%Goes RIGHT
                        disp(workspace);
                        heatmap(workspace);
                    end
                else
                    workspace(initial_pos(i),initial_pos(j)) = 0.5;
                    while (initial_pos(j)>1)&&(workspace(initial_pos(i),initial_pos(j)-1) == 3)
                        workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                        initial_pos(i)=initial_pos(i)-1;%The forward position
                        workspace(initial_pos(i),initial_pos(j)) = 2;%Goes UP
                    end
                    workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                    initial_pos(j)=initial_pos(j)-1;%The left position
                    workspace(initial_pos(i),initial_pos(j)) = 2;%Goes LEFT
                    disp(workspace);
                    heatmap(workspace);
                end
            end
        end
        while initial_pos(j)>9%Go LEFT
            if workspace(initial_pos(i),initial_pos(j)-1) ~= 3%If there isn't an obstacle to the left
                workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                initial_pos(j)=initial_pos(j)-1;%The left position
                workspace(initial_pos(i),initial_pos(j)) = 2;%Goes LEFT
                disp(workspace);
                heatmap(workspace);
            else%Dodge the obstacle
                if (initial_pos(i)<20)&&(workspace(initial_pos(i)+1,initial_pos(j)) ~= 3)%No obstacle behind
                    while(workspace(initial_pos(i),initial_pos(j)-1) == 3)&&(initial_pos(i)<20)&&(workspace(initial_pos(i)+1,initial_pos(j)) ~= 3)
                        workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                        initial_pos(i)=initial_pos(i)+1;%The position behind
                        workspace(initial_pos(i),initial_pos(j)) = 2;%Goes BACK
                        disp(workspace);
                        heatmap(workspace);
                    end
                elseif (initial_pos(i)>1)&&(workspace(initial_pos(i)-1,initial_pos(j)) ~= 3)%No ostacle forward
                    while(workspace(initial_pos(i),initial_pos(j)-1) == 3)&&(initial_pos(i)>1)&&(workspace(initial_pos(i)-1,initial_pos(j)) ~= 3)
                        workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                        initial_pos(i)=initial_pos(i)-1;%The forward position
                        workspace(initial_pos(i),initial_pos(j)) = 2;%Goes UP
                        disp(workspace);
                        heatmap(workspace);
                    end
                else
                    workspace(initial_pos(i),initial_pos(j)) = 0.5;
                    while(initial_pos(i)<20)&&(workspace(initial_pos(i)+1,initial_pos(j)) == 3)
                        workspace(initial_pos(i),initial_pos(j)) = 0.5;
                        initial_pos(j)=initial_pos(j)+1;%The right position
                        workspace(initial_pos(i),initial_pos(j)) = 2;%Goes RIGHT
                    end
                    workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                    initial_pos(i)=initial_pos(i)+1;%The position behind
                    workspace(initial_pos(i),initial_pos(j)) = 2;%Goes BACK
                    disp(workspace);
                    heatmap(workspace);
                end
            end
        end
        while initial_pos(j)<9%Go RIGHT
            if workspace(initial_pos(i),initial_pos(j)+1) ~= 3%If there isn't and obstacle to the right
                workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                initial_pos(j)=initial_pos(j)+1;%The right position
                workspace(initial_pos(i),initial_pos(j)) = 2;%Goes RIGHT
                disp(workspace);
                heatmap(workspace);
            else%Dodge the obstacle
                if (initial_pos(i)<20)&&(workspace(initial_pos(i)+1,initial_pos(j)) ~= 3)%No obstacle behind
                    while (workspace(initial_pos(i),initial_pos(j)+1) == 3)&&(initial_pos(i)<20)&&(workspace(initial_pos(i)+1,initial_pos(j)) ~= 3)
                        workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                        initial_pos(i)=initial_pos(i)+1;%The position behind
                        workspace(initial_pos(i),initial_pos(j)) = 2;%Goes BACK
                        disp(workspace);
                        heatmap(workspace);
                    end
                elseif (initial_pos(i)>1)&&(workspace(initial_pos(i)-1,initial_pos(j)) ~= 3)%No obstacle forward
                    while (workspace(initial_pos(i),initial_pos(j)+1) == 3)&&(initial_pos(i)>1)&&(workspace(initial_pos(i)-1,initial_pos(j)) ~= 3)
                        workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                        initial_pos(i)=initial_pos(i)-1;%The forward position
                        workspace(initial_pos(i),initial_pos(j)) = 2;%Goes UP
                        disp(workspace);
                        heatmap(workspace);
                    end
                else
                    workspace(initial_pos(i),initial_pos(j)) = 0.5;
                    while (initial_pos(i)<20)&&(workspace(initial_pos(i)+1,initial_pos(j)) == 3)
                        workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                        initial_pos(j)=initial_pos(j)-1;%The left position
                        workspace(initial_pos(i),initial_pos(j)) = 2;%Goes LEFT 
                    end
                    workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
                    initial_pos(i)=initial_pos(i)+1;%The position behind
                    workspace(initial_pos(i),initial_pos(j)) = 2;%Goes BACK
                    disp(workspace);
                    heatmap(workspace);
                end
            end
        end
    end
    disp("The robot reached the charger!");
end