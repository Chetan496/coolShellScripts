tmux new-session -d -s kustomizeSession 
sleep 4
tmux send-keys -t kustomizeSession.0 "tmux split-window -h" ENTER 
tmux send-keys -t kustomizeSession.0 "tmux split-window -v" ENTER 
tmux send-keys -t kustomizeSession.0 "tmux select-pane -t 0" ENTER 
tmux send-keys -t kustomizeSession.0 "tmux split-window -v" ENTER 
sleep 2
tmux send-keys -t kustomizeSession.0 "clear" ENTER
tmux send-keys -t kustomizeSession.1 "clear" ENTER
tmux send-keys -t kustomizeSession.2 "clear" ENTER
tmux send-keys -t kustomizeSession.3 "clear" ENTER
tmux send-keys -t kustomizeSession.0 "watch -n 30 flux get sources git -A" ENTER
tmux send-keys -t kustomizeSession.1 "watch -n 30 flux get kustomizations -A" ENTER 
tmux send-keys -t kustomizeSession.2 "watch -n 30 flux get images all" ENTER 
tmux send-keys -t kustomizeSession.3 "watch -n 30 kubectl get pods -n dsp-dev" ENTER 
sleep 1
tmux attach-session -t kustomizeSession

