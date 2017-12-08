#!/bin/bash
dotnet --info
echo STARTED dotnet build
cd StratisBitcoinFullNode/src
dotnet build -c Debug ${path} -v m

echo STARTED dotnet test

ANYFAILURES=false

echo "Running Integration Tests.."; 
cd Stratis.Bitcoin.IntegrationTests
COMMAND="dotnet test --no-build -c Debug -v m"
$COMMAND
EXITCODE=$?
echo exit code for $testProject: $EXITCODE

if [ $EXITCODE -ne 0 ] ; then
    ANYFAILURES=true
fi

cd ..
done

echo FINISHED dotnet test
if [[ $ANYFAILURES == "true" ]] ; then
    exit 1
fi
