# Record daily activity using the Activity logger gem

The Activity Logger gem is used to store short descriptions to a Dynarex file on a daily basis. The previous days are stored in a subdirectory called 'archive'.

    require 'activity-logger'

    al = ActivityLogger.new
    al.create "I'm #testing the activity logger"
    al.create "I'm having a salad for #lunch"
    al.create "playing darts #recreation"

<pre>
$ more dynarexdaily.xml
&lt;?xml version='1.0' encoding='UTF-8'?&gt;
&lt;entries&gt;
  &lt;summary&gt;
    &lt;date&gt;2013-05-24 13:29:12 +0100&lt;/date&gt;
    &lt;recordx_type&gt;dynarex&lt;/recordx_type&gt;
    &lt;format_mask&gt;[!time] [!desc]&lt;/format_mask&gt;
    &lt;schema&gt;entries[date]/entry(time, desc)&lt;/schema&gt;
  &lt;/summary&gt;
  &lt;records&gt;
    &lt;entry id='1' created='2013-05-24 13:29:12 +0100' last_modified=''&gt;
      &lt;time&gt;2013-05-24 13:29:11 +0100&lt;/time&gt;
      &lt;desc&gt;I'm #testing the activity logger&lt;/desc&gt;
    &lt;/entry&gt;
    &lt;entry id='2' created='2013-05-24 13:29:13 +0100' last_modified=''&gt;
      &lt;time&gt;2013-05-24 13:29:12 +0100&lt;/time&gt;
      &lt;desc&gt;I'm having a salad for #lunch&lt;/desc&gt;
    &lt;/entry&gt;
    &lt;entry id='3' created='2013-05-24 13:29:14 +0100' last_modified=''&gt;
      &lt;time&gt;2013-05-24 13:29:13 +0100&lt;/time&gt;
      &lt;desc&gt;playing darts #recreation&lt;/desc&gt;
    &lt;/entry&gt;
  &lt;/records&gt;
&lt;/entries&gt;
</pre>

gem activitylogger activities dynarex daily
