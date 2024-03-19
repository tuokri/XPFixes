/**
 * Copyright (c) 2024 Tuomo Kriikkula
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

// Performs early stats initialization to avoid accidentally
// resetting stats and experience on EGS clients.
class XPFixesMutator extends ROMutator
    config(Mutator_XPFixes);

function NotifyLogin(Controller NewPlayer)
{
    local ROPlayerController ROPC;

    ROPC = ROPlayerController(NewPlayer);
    if (ROPC != None
        && ROPC.PlayerReplicationInfo != None
        && ROPC.PlayerReplicationInfo.bEgsClient
    )
    {
        `xpflog("performing early stats init for"
            @ ROPC @ ROPC.PlayerReplicationInfo.PlayerName
            @ ROPC.PlayerReplicationInfo.UniqueId
        );

        ROPC.InitializeStats();
    }

    super.NotifyLogin(NewPlayer);
}

DefaultProperties
{

}
