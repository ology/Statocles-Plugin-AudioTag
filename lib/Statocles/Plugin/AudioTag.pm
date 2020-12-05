package Statocles::Plugin::AudioTag;

# ABSTRACT: Change audio file anchors to audio elements

our $VERSION = '0.0103';

use Statocles::Base 'Class';
with 'Statocles::Plugin';

=head1 SYNOPSIS

  # site.yml
  site:
    class: Statocles::Site
    args:
        plugins:
            audio_tag:
                $class: Statocles::Plugin::AudioTag
                $args:
                     file_type: 'ogg'

=head1 DESCRIPTION

C<Statocles::Plugin::AudioTag> changes audio file anchor elements to
audio elements.

=head1 ATTRIBUTES

=head2 file_type

The file type to replace.

Default: C<mp3>

=cut

has file_type => (
    is      => 'ro',
    isa     => Str,
    default => sub { 'mp3' },
);

=head1 METHODS

=head2 register

Register this plugin to install its event handlers. Called automatically.

=cut

sub register {
    my ($self, $site) = @_;
    $site->on(build => sub {
        my ($event) = @_;
        for my $page ($event->pages->@*) {
            if ($page->DOES('Statocles::Page::Document')) {
                $page->dom->find('a[href$=.'. $self->file_type .']' )->each(sub {
                    my ($el) = @_;
                    $el->replace(sprintf '<audio controls><source type="audio/%s" src="%s"></audio>', $self->file_type, $el->attr('href'));
                } );
            }
        }
    });
}

1;
__END__

=head1 SEE ALSO

L<Statocles>

L<Statocles::Plugin>

=cut
