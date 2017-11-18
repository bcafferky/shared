##################################################
####### WMF 5.0 November 2014 Preview ###########
##################################################
#
# From http://trevorsullivan.net/2014/10/25/implementing-a-net-class-in-powershell-v5/

class Beer {
    # Property: Holds the current size of the beer.
    [Uint32] $Size;
    # Property: Holds the name of the beer's owner.
    [String] $Name;

    # Constructor: Creates a new Beer object, with the specified
    #              size and name / owner.
    Beer([UInt32] $NewSize, [String] $NewName) {
        # Set the Beer size
        $this.Size = $NewSize;
        # Set the Beer name
        $this.Name = $NewName;
    }

    # Method: Drink the specified amount of beer.
    # Parameter: $Amount = The amount of beer to drink, as an 
    #            unsigned 32-bit integer.
    [void] Drink([UInt32] $Amount) {
        try {
            $this.Size = $this.Size - $Amount;
        }
        catch {
            Write-Warning -Message 'You tried to drink more beer than was available!';
        }
    }

    # Method: BreakGlass resets the beer size to 0.
    [void] BreakGlass() {
        Write-Warning -Message 'The beer glass has been broken. Resetting size to 0.';
        $this.Size = 0;
    }
}

# Create a new 16 ounce beer, named 'Trevor'
$MyBeer = [Beer]::new(16, 'Bryan');

# We drink 10 out of 16 ounces, leaving 6 left.
$MyBeer.Drink(10);
$MyBeer

# The second call fails gracefully now, because we only have 6 ounces left.
$MyBeer.Drink(10);
$MyBeer

$MyBeer.BreakGlass();
$MyBeer 