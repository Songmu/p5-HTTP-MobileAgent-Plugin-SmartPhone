package HTTP::MobileAgent::Plugin::SmartPhone;
use strict;
use warnings;
use utf8;
our $VERSION = '0.01';

sub HTTP::MobileAgent::is_smartphone {
    my $self = shift;
    $self->is_ios || $self->is_android;
}

sub HTTP::MobileAgent::is_ios {
    my $self = shift;
    $self->user_agent =~ /iP(?:one|od|ad)/;
}

sub HTTP::MobileAgent::is_iphone {
    shift->user_agent =~ /iPhone/;
}

sub HTTP::MobileAgent::is_ipad {
    shift->user_agent =~ /iPad/;
}

sub HTTP::MobileAgent::is_android {
    shift->user_agent =~ /Android/;
}

sub HTTP::MobileAgent::is_android_tablet {
    my $self = shift;
    $self->is_android && $self->user_agent !~ /Mobile/
}

sub HTTP::MobileAgent::ios_full_version {
    my $self = shift;
    return () unless $self->is_ios;

    local $1;
    my $full_version;
    if ($self->user_agent =~ /CPU (?:iPhone )?(?:OS ((?:\d+)(?:_\d+)*) )?like/) {
        $full_version = $1 || 1;
    }
    $full_version;
}

sub HTTP::MobileAgent::ios_version {
    my ($version) = (shift->ios_full_version || '') =~ /^(\d+)/;
    $version;
}

sub HTTP::MobileAgent::is_tablet {
    my $self = shift;
    $self->is_ipad || $self->is_android_tablet;
}

1;
__END__

=head1 NAME

HTTP::MobileAgent::Plugin::SmartPhone -

=head1 SYNOPSIS

  use HTTP::MobileAgent::Plugin::SmartPhone;

=head1 DESCRIPTION

HTTP::MobileAgent::Plugin::SmartPhone is

=head1 AUTHOR

Masayuki Matsuki E<lt>y.songmu@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
