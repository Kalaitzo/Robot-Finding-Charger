%% A) Empy workspace
clc;
clear;
close all;

initial_pos = [randi([1,20],5,1) randi([1,20],5,1)]; %Initial robot positions

for i = 1:5
   j = i + 5;
   workspace = zeros(20);%Initialize workspace
   workspace(3,9) = 1;%Set target position
   workspace(initial_pos(i),initial_pos(j)) = 2;%Set robot to the workspace
   if (initial_pos(i) == 3) && (initial_pos(j) == 9)%Check if the robot was places on the charger
       disp("The robot was initialized at the targer position!");
   else%Take the robot to the charger
       disp(workspace);
       figure;
       start = [initial_pos(i) initial_pos(j)];
       while (initial_pos(i)~=3)||(initial_pos(j)~=9)
           while initial_pos(i)<3%Robot goes down
               workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
               initial_pos(i)=initial_pos(i)+1;
               workspace(initial_pos(i),initial_pos(j)) = 2;
               disp(workspace);
           end
           while initial_pos(i)>3%Robot goes up
               workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
               initial_pos(i)=initial_pos(i)-1;
               workspace(initial_pos(i),initial_pos(j)) = 2;
               disp(workspace);
           end
           while initial_pos(j)<9%Robot goes right
               workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
               initial_pos(j)=initial_pos(j)+1;
               workspace(initial_pos(i),initial_pos(j)) = 2;
               disp(workspace);
           end
           while initial_pos(j)>9%Robot goes left
               workspace(initial_pos(i),initial_pos(j)) = 0.5; %The robot leaves its previous position
               initial_pos(j)=initial_pos(j)-1;
               workspace(initial_pos(i),initial_pos(j)) = 2;
               disp(workspace);
           end
           workspace(start(1), start(2)) = 5;
           heatmap(workspace);
       end
       disp("The robot reached the charger!")
   end
end
