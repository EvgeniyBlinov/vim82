# vim82

Vim for 8.2 and upper

## requirements

* vim 8.2

* python3

* coc.vim

    * node > 12
    * yarn

### Usage

plantuml svg browser autoupdate

```
while /bin/true
do
    inotifywait -e close_write ./*.svg;
    cwid=$(xdotool getwindowfocus) # Save the current window
    twid=$(xdotool search --name "Mozilla Firefox")
    xdotool windowactivate $twid
    sleep 0.1 # The key event might be sent before the window has been fully activated
    xdotool key CTRL+R;               # Reload Firefox
    xdotool windowactivate $cwid # Done, now go back to where we were
done
```
