#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;

use Statocles::Test qw(build_test_site);

use_ok 'Statocles::Plugin::AudioTag';

my $site = build_test_site();
my $page = Statocles::Page::Plain->new(
    path => 'test.html',
    site => $site,
    content => '<p><a href="test.mp3">test.mp3</a></p>',
);

my $plugin = new_ok 'Statocles::Plugin::AudioTag';

my $got = $plugin->audio_tag($page);
like $got->dom, qr|<p><audio controls><source src="test.mp3" type="audio/mp3"></audio></p>|, 'audio_tag';

new_ok 'Statocles::Plugin::AudioTag' => [ file_type => 'ogg' ];

done_testing();
