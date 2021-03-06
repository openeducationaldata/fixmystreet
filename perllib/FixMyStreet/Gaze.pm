package FixMyStreet::Gaze;

use strict;
use warnings;

use FixMyStreet;
use mySociety::Gaze;

sub get_radius_containing_population ($$) {
    my ($lat, $lon) = @_;

    # Don't call out to a real gaze when testing.
    return 10.0 if FixMyStreet->test_mode;

    my $dist = eval {
        mySociety::Locale::in_gb_locale {
            mySociety::Gaze::get_radius_containing_population($lat, $lon, 200_000);
        };
    };
    if ($@) {
        # Error fetching from gaze, let's fall back to 10km
        $dist = 10;
    }
    $dist = int( $dist * 10 + 0.5 ) / 10.0;
    return $dist;
}

sub get_country_from_ip {
    my ($ip) = @_;
    return 'GB' if FixMyStreet->test_mode;
    # uncoverable statement
    return mySociety::Gaze::get_country_from_ip($ip);
}

1;
