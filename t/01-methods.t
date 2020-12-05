#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;

use_ok 'Statocles::Plugin::AudioTag';

new_ok 'Statocles::Plugin::AudioTag';

new_ok 'Statocles::Plugin::AudioTag' => [ file_type => 'ogg' ];

done_testing();
